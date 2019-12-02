#lang at-exp racket

(require website-js racket/runtime-path)

(define-runtime-path js-path "js")
(define-runtime-path css-path "css")

(define (js-files)
  (list
    (page jexcel.js
          (file->string (build-path js-path "jexcel.js")))
    (page jsuites.js
          (file->string (build-path js-path "jsuites.js")))))

(define (css-files)
  (list
    (page jexcel.css
          (file->string (build-path css-path "jexcel.css")))
    (page jsuites.css
          (file->string (build-path css-path "jsuites.css")))))

(define (sheet-files)
  (list
   (css-files) 
   (js-files)))

(define (sheet)
  (enclose
   (div id: "sheet")
   (script
    ([data2 @js{[
                 [ 'Cheese', 10, 1.10, '=B1*C1'],
                 [ 'Apples', 30, 0.40, '=B2*C2'],
                 [ 'Carrots', 15, 0.45, '=B3*C3'],
                 [ 'Oranges', 20, 0.49, '=B4*C4'],
                 ]}]
     [table @js{jexcel(document.getElementById('sheet'),
                                              {
                                               data: @data2,
                                               colHeaders: [ 'Product', 'Quantity', 'Price', 'Total' ],
                                               colWidths: [ 300, 100, 100, 100 ],
                                               columns: [
                                                         { type: 'autocomplete', source:[ 'Apples','Bananas','Carrots','Oranges','Cheese','Pears' ] },
                                                         { type: 'number' },
                                                         { type: 'number' },
                                                         { type: 'number' },
                                                         ],
                                               rowResize:true,
                                               })}])
    )))


(define (sheet-demo)
  (page index.html
        (content
         #:head (list (include-css "jexcel.css")
                      (include-css "jsuites.css")
                      (include-js "jsuites.js")
                      (include-js "jexcel.js"))
         (sheet))))

(render (list (bootstrap-files)
              (sheet-files)
              (sheet-demo))
        #:to "out")
