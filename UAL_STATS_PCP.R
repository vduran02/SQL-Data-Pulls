library(data.table)
library(ggplot2)
library(tidyverse)
library(clipr)

UAL_visit <- fread("/Users/valeriaduran/Downloads/UAL_pcp_spec.csv")
UAL_clean <- UAL_visit %>% 
  group_by(dw_member_id) %>% 
  mutate(pilot = if(any(pilot == 'Pilot')) 'Pilot' else 'No') %>% ungroup() %>% distinct() %>% setDT()

UAL_clean %>% count(pilot)


UAL_visit %>% group_by(years) %>% summarise(total_mem = n_distinct(dw_member_id))

visit_summ <- UAL_clean[visit_cnt != 0,.(visit_count = sum(visit_cnt)), .(years,dw_member_id,doc_type,pilot)][,.(visit_type = fifelse(visit_count == 0, 'no_v',fifelse(visit_count == 1, '1_v',fifelse(visit_count == 2, '2_v',fifelse(visit_count >2, '3+_v',NA_character_))))),.(years,dw_member_id,visit_count,pilot,doc_type)]

stats_pcp <- dcast(visit_summ, years+doc_type~visit_type, fun=list(length, sum), value.var=list("dw_member_id", "visit_count"))
stats_pcp_tidy <- visit_summ %>% filter(visit_count != 0) %>% group_by(years,doc_type, visit_type) %>% 
  summarise(total_visits = sum(visit_count),
            members = n())

write_clip(stats_pcp_tidy)

# visit_summary <- UAL_visit[,.(visit_cnt = sum(visit_cnt)), .(years,dw_member_id,pilot)][,.(visit_type = fifelse(visit_cnt == 0, 'no_v',fifelse(visit_cnt == 1, '1_v',fifelse(visit_cnt == 2, '2_v',fifelse(visit_cnt >2, '3+_v',NA_character_))))),.(years,dw_member_id,visit_cnt,pilot)]
# 
# stats<- dcast(visit_summary, years+pilot~visit_type, fun.aggregate = length, value.var = "dw_member_id")
# visit_summary %>% filter(visit_cnt==0 & years == 2018) %>% summarise(total_visits = sum(visit_cnt),
#                                                members = n())
# 
# 
# write_clip(dcast(visit_summary, years+age_rng~visit_type, fun.aggregate = length, value.var = "dw_member_id"))
# stats_state<- visit_summary[,.(visit_cnt = length(dw_member_id)), .(years,doc_type,visit_type,prov_type)]
# 
# 
# stats_state %>% filter(memberstate != 'Blank' & memberstate != 'ZZ') %>% ggplot(aes(x=memberstate, y = visit_cnt, group = visit_type, fill = visit_type))  +
#   geom_bar(stat="identity") + ggtitle("Visit Count by State For 2018-2021")  + theme_bw() +
#   theme(plot.title = element_text(hjust = 0.5)) #+ facet_grid(years~.)
# 
# 
# stats_state %>% group_by(doc_type, visit_type,prov_type) %>% summarise(visit_cnt1 = sum(visit_cnt)) %>% ggplot(aes(x=prov_type, y = visit_cnt1, group = visit_type, fill = visit_type))  +
#   geom_bar(position="dodge", stat = 'identity')  + ggtitle("Visit Count by Physician Type For 2018-2021")  + theme_bw() +
#   theme(plot.title = element_text(hjust = 0.5))  + facet_grid(doc_type~.)
# dev.off()
# write_clip(stats)
# unique(stats_state$prov_type)
# 
# 
# 
# dupes <- visit_summ %>% filter(years == 2018 & doc_type == 'pcp' & visit_type == '2_v')
# 
# dupes_v <- dupes %>% 
#   group_by(dw_member_id) %>% 
#   filter(n()>1)
# 
# visit_summ %>% filter(years == 2018) %>%
#   group_by(years) %>% 
#   arrange(desc(years), .by_group = TRUE) %>%
#   filter(row_number() == 1)
