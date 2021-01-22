library(arules)

# baca file dalam class transaction
transaksi <- read.transactions(
    "Dataset/market_basket_transaction.csv",
    format = "basket",
    sep = ","
)

# Kombinasi produk minimal 2 item, dan maksimum 3 item
# Kombinasi produk itu muncul setidaknya 10 dari dari seluruh transaksi => 10/length(transaksi)
# Memiliki tingkat confidence minimal 50 persen
mba <- apriori(
    transaksi,
    parameter = list(
        supp = 10 / length(transaksi),
        conf = 0.5,
        maxlen = 3,
        minlen = 2
    )
)

# buang rules yang tidak perlu (rules yang ada di dalam rule yang lebih besar)
# vector yang berisi posisi rules yang berulang
rule_subset <- which(colSums(is.subset(mba, mba)) > 1)
# buang rule_subset
clean_mba <- mba[-rule_subset]

# itemset yang memiliki asosiasi atau hubungan erat teratas (10)
# filter berdasarkan lift
filtered_rules <- head(mba, n = 10, by = "lift")

# masukkan hasil ke dalam file
write(filtered_rules, file="Output/kombinasi_retail.txt")