library(arules)

# baca file dalam class transaction
transaksi <- read.transactions(
    "Dataset/market_basket_transaction.csv",
    format = "basket",
    sep = ","
)

# dapatkan frekuensi item
item <- itemFrequency(transaksi, type = "absolute")
# urutkan dari tertinggi
item <- sort(item, decreasing = TRUE)
# ambil 10 teratas
item <- item[1:10]
# masukkan hasilnya ke data frame
item <- data.frame(
    "Nama Produk" = names(item),
    "Jumlah" = item,
    row.names = NULL
)

write.csv(item, file = "Output/top10_item_retail.txt")