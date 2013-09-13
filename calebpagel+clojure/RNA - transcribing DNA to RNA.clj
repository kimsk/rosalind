(ns dnatorna)

;; Attempt to solve Rosalind - Transcribing DNA to RNA

(defn dnatorna [original]
  (clojure.string/replace original #"T" {"T" "U"})
)

(= (dnatorna "GATGGAACTTGACTACGTAAATT") "GAUGGAACUUGACUACGUAAAUU")