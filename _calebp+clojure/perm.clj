(defn generate-for-bindings [n]
  (let [rng (range 1 (inc n))
        symbols (map #(symbol (str "x" %)) rng)
        pairs (loop [x (first symbols)
                      prior #{}
                      more (rest symbols)
                      result []]
                 (if-not x
                   result
                   (recur (first more)
                          (conj prior x)
                          (rest more)
                          (conj result [x prior]))))]
    (mapcat (fn [[x priors]]
              `[~x (remove ~priors ~(vec rng))]) pairs)))

(defn symbols [n]
  (map #(symbol (str "x" %))
       (range 1 (inc n))))

;; First thing that came to mind for generating combinations was a for
;; loop.  Then I had to figure out if I could dynamically generate a
;; for loop with n bindings.  So... a macro.  Probably not the best
;; solution, but fun.  This macro has the
;; problem when it is passed a symbol instead of a literal number, but
;; I have to get to get back to work
(defmacro perms [n]
  `(for ~(vec (generate-for-bindings n))
     ~(vec (symbols n))))

(let [ps (perms 4)]
  (println (count ps))
  (doseq [p ps]
    (println (clojure.string/join " " p))))


