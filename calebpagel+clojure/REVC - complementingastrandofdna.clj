(ns dnacompl)

;; Attempt to solve Rosalind - REVC - Complementing a Strand of DNA

(defn dnatorna [original]
  (clojure.string/reverse (clojure.string/replace original #"A|C|G|T" {"A" "T" "C" "G" "G" "C" "T" "A"}))
)

(= (dnatorna "AAAACCCGGT") "ACCGGGTTTT")


