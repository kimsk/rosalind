(ns FIB)


(defn makebunnies [babies, adults, totalmonths littersize currentmonth]
          (if (> totalmonths currentmonth)
             (makebunnies (* adults littersize) (+ adults babies) totalmonths littersize (+ 1 currentmonth))
                (+ adults babies)
                  )

  )

(defn dynamo [months, littersize]
    (makebunnies 1 0 months littersize 1)
  )


(addthem (* adults babies) (+ adults babies) totalmonths littersize (+ 1 currentmonth))

(dynamo 28 4)

(dynamo 1 3)

(dynamo 2 3)

(dynamo 3 3)

(dynamo 4 3)

(dynamo 5 3)

(dynamo 6 3)

(dynamo 7 3)

(dynamo 8 3)