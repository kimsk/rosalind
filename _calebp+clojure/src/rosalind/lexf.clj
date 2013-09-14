(ns rosalind.lexf
  (:require [clojure.math.combinatorics :as cmb]))

(defn run [alphabet n]
  (doseq [s (cmb/selections alphabet n)]
    (println (apply str s))))

(def sample-answer
"TT
TA
TG
TC
AT
AA
AG
AC
GT
GA
GG
GC
CT
CA
CG
CC
")

(assert (= sample-answer
           (with-out-str
             (run "TAGC" 2))))

