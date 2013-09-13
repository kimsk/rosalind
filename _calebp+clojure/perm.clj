
;; First thing that came to mind for generating combinations was a for
;; loop.  Then I had to figure out if I could dynamically generate a
;; for loop with n bindings.  So... a macro.  Probably not the best
;; solution, but fun.  This macro has a
;; problem when it is passed a symbol instead of a literal number, but
;; I have to get back to work
(defmacro perms [n]
  (let [numbers (vec (range 1 (inc n)))
        symbols (mapv #(symbol (str "x" %))
                      numbers)
        pairs (for [i (range n)]
                [(nth symbols i)
                 (set (subvec symbols 0 i))])
        binding-forms (mapcat (fn [[x priors]]
                                `[~x (remove ~priors ~numbers)])
                              pairs)]
    `(for ~(vec binding-forms)
       ~(vec symbols))))

(comment
  (let [ps (perms 4)]
    (println (count ps))
    (doseq [p ps]
      (println (clojure.string/join " " p)))))
