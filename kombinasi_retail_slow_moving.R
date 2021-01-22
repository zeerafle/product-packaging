library(arules)

# baca file dalam class transaction
transaksi <- read.transactions(
    "Dataset/market_basket_transaction.csv",
    format = "basket",
    sep = ","
)

# Kombinasi produk minimal 2 item, dan maksimum 3 item
# Kombinasi produk itu muncul setidaknya 10 dari dari seluruh transaksi => 10/length(transaksi)
# Memiliki tingkat confidence minimal 10 persen
mba <- apriori(
    transaksi,
    parameter = list(
        supp = 10 / length(transaksi),
        conf = 0.1,
        maxlen = 3,
        minlen = 2
    )
)

# anggaplah 3D TRADITIONAL CHRISTMAS STICKERS dan HEART T-LIGHT HOLDER ingin dicari kombinasi yang bagus untuk dipaketkan
# maka produk yang diinginkan harus berada di rhs
# temukan 3 rules yang paling kuat untuk masing masing produk
xmas_stickers <- head(
    subset(mba, rhs %ain% "3D TRADITIONAL CHRISTMAS STICKERS"),
    n = 3,
    by = "lift"
)
light_holder <- head(
    subset(mba, rhs %ain% "HEART T-LIGHT HOLDER"),
    n = 3,
    by = "lift"
)

# simpan hasilnya ke file
write(
    c(xmas_stickers, light_holder),
    file = "Output/kombinasi_retail_slow_moving.txt"
)