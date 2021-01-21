library(arules)

# baca file dalam class transaction
transaksi <- read.transactions(
    "C:\\Users\\vsefa\\OneDrive\\Projects\\Machine Learning for Retail with R Product Packaging\\Dataset\\market_basket_transaction.csv",
    format = "basket",
    sep = ","
)

# dapatkan frekuensi item
item <- itemFrequency(transaksi, type = "absolute")
# urutkan dari terendah
item <- sort(item)
# ambil 10 terbawah
item <- item[1:10]
# masukkan hasilnya ke data frame
item <- data.frame(
    "Nama Produk" = names(item),
    "Jumlah" = item,
    row.names = NULL
)

write.csv(item, file = "Output/bottom10_item_retail.txt")