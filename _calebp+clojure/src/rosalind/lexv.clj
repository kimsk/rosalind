(ns rosalind.lexv
  (:require [clojure.math.combinatorics :as cmb]))


(defn make-comparator [alphabet]
  (let [order-values (zipmap alphabet (range))]
    (fn [a b]
      (or (first
           (remove zero?
                   (map (fn [an bn]
                          (.compareTo (order-values an)
                                      (order-values bn))) a b)))
          0))))

(defn selections [alphabet n]
  (mapcat (partial cmb/selections alphabet)
          (range 1 (inc n))))

(defn run [alphabet n]
  (doseq [s (map #(apply str %)
                 (sort (make-comparator alphabet)
                       (selections alphabet n)))]
    (println s)))