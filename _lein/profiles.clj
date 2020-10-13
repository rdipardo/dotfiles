{:user {:dependencies [[antq/antq "0.13.0"]
                       [nrepl "0.8.3"]]
        :aliases {"outdated" ["run" "-m" "antq.core"]}}
 :repl {:plugins [[cider/nrepl "0.3.0"]
                  [lein-cljfmt "0.7.0"]]
        :dependencies [[nrepl "0.8.3"]
                       [cider/piggieback "0.5.2"]
                       [figwheel-sidecar "0.5.20"]]
        :repl-options {:nrepl-middleware [cider.piggieback/wrap-cljs-repl]}}}
