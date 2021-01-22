library(readxl)
library(tidyverse)
library(plyr)

# baca file excel ke data frame
retail <- read_excel("Dataset/online_retail_II.xlsx", "Year 2009-2010")
# buang missing values dengan fungsi na.omit()
retail <- na.omit(retail)
# edit tipe kolom dengan fungsi mutate
retail_new <- retail %>%
    # kolom description jadi factor
    mutate(Description = as.factor(Description)) %>%
    # kolom country jadi factor
    mutate(Country = as.factor(Country)) %>%
    # buat 2 kolom baru masing-masing berisi date dan time diambil dari kolom InvoiceDate
    mutate(Date = as.Date(InvoiceDate)) %>%
    mutate(TransTime = format(InvoiceDate, "%H:%M:%S")) %>%
    # edit kolom Invoice jadi numeric
    mutate(Invoice = as.numeric(Invoice))

# ----buat data transaksi jadi basket format----
# gabungkan description dipisahkan koma berdasarkan Invoice dan Date yang sama
transaction_data <- ddply(
    retail_new,
    c("Invoice", "Date"),
    function(df) paste(df$Description, collapse = ",")
)

# set kolom Invoice dan Date ke NULL
transaction_data$Invoice <- NULL
transaction_data$Date <- NULL
# ganti nama kolom jadi "items"
colnames(transaction_data) <- c("items")

# simpan data transaksi ke file baru
write.csv(
    transaction_data,
    "Dataset/market_basket_transaction.csv",
    quote = FALSE,
    row.names = FALSE
)