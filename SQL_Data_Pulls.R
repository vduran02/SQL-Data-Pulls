# Function to take the current clipboard contents, and turn them into a parentheses'd list for SQL queries, since I do that a lot now.
# What it does:
# Takes the contents of the clipboard, and writes it to a table.
# (If you set Data = ... in the function, it uses that instead of the clipboard)
# Takes the first column of the resulting table, and transforms it into a SQL style list for "IN"
# If you want a different column, you can set col = ... in the function
# If the data was simply a list, it still works, as it treats that as the first column of a table.

SQL_Clip_List <- function( col = 1, Data = NULL) {
  
  if(is.null(Data)) a <- read_clip_tbl(header = FALSE) 
  else a <- Data
  a <- mutate(a, across(everything(), as.character))
  a <- replace(a, is.na(a), "NA")
  a <- a[col] %>% unlist() %>% unique()
  b <- str_c( "(" , 
              str_c("'", a, "'", collapse = ", "),
              ")")
  write_clip(b)
  b
}

write_clip(Accuracy_Check)
SQL_Clip_List()