(defn symbols [n]
  (mapv #(symbol (str "x" %))
        (range 1 (inc n))))

(defn generate-for-bindings [n]
  (let [symbols (symbols n)
        numbers (range 1 (inc n))
        pairs (for [i (range n)]
                [(nth symbols i)
                 (set (subvec symbols 0 i))])]
    (mapcat (fn [[x priors]]
              `[~x (remove ~priors ~(vec numbers))]) pairs)))

;; First thing that came to mind for generating combinations was a for
;; loop.  Then I had to figure out if I could dynamically generate a
;; for loop with n bindings.  So... a macro.  Probably not the best
;; solution, but fun.  This macro has the
;; problem when it is passed a symbol instead of a literal number, but
;; I have to get to get back to work
(defmacro perms [n]
  `(for ~(vec (generate-for-bindings n))
     ~(vec (symbols n))))

(comment
  (let [ps (perms 3)]
    (println (count ps))
    (doseq [p ps]
      (println (clojure.string/join " " p)))))


