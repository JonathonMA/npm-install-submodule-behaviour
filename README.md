# Investigation of npm install behaviour

Having submodules in the same repo as a parent application seems
like a great idea, and using `file:<module-path>` in the top-level
dependencies section supports this. However, we experience an
"unflattening" of modules after we install an individual module by
name.

## Sample run

    node version: v4.2.1
    npm version: 3.3.12
     _______________________________
    < First: do a plain npm install >
     -------------------------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
    npm-install-submodule-behaviour@0.0.1 /Users/jonathona/Code/npm-install-submodule-behaviour
    ├─┬ react@0.14.2
    │ ├─┬ envify@3.4.0
    │ │ ├─┬ jstransform@10.1.0
    │ │ │ ├── base62@0.1.1
    │ │ │ ├── esprima-fb@13001.1001.0-dev-harmony-fb
    │ │ │ └─┬ source-map@0.1.31
    │ │ │   └── amdefine@1.0.0
    │ │ └── through@2.3.8
    │ └─┬ fbjs@0.3.2
    │   ├── core-js@1.2.6
    │   ├─┬ loose-envify@1.1.0
    │   │ └── js-tokens@1.0.2
    │   ├─┬ promise@7.0.4
    │   │ └── asap@2.0.3
    │   ├── ua-parser-js@0.7.9
    │   └── whatwg-fetch@0.9.0
    ├── submodule1@0.0.1
    └── submodule2@0.0.1

     ________________
    < React Count: 1 >
     ----------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
     ___________________________________
    < Second: install submodule by name >
     -----------------------------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
    react@0.14.2 node_modules/react -> node_modules/submodule1/node_modules/react
    npm-install-submodule-behaviour@0.0.1 /Users/jonathona/Code/npm-install-submodule-behaviour
    ├─┬ submodule1@0.0.1
    │ └── react@0.14.2
    └─┬ submodule2@0.0.1
      └── react@0.14.2

     ________________
    < React Count: 2 >
     ----------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
     ___________________________________
    / Finish up with: another plain npm \
    \ install                           /
     -----------------------------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
    npm-install-submodule-behaviour@0.0.1 /Users/jonathona/Code/npm-install-submodule-behaviour
    ├── react@0.14.2
    ├─┬ submodule1@0.0.1
    │ └── react@0.14.2
    └─┬ submodule2@0.0.1
      └── react@0.14.2

     ________________
    < React Count: 3 >
     ----------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
