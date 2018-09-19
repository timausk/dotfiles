# ATOM

## Installation
__setup-new-machine.sh__ installs Atom and creates symbolic links for .atom configs

## Package-list handling
To keep installed atom packages across machines in sync we use a packaglist.txt file which lists all installed packages.
Doing it this way prevents versioning the whole packages.


For installing packages from the packaglist.txt run:  
`atom_pkg_install`

After installing a new package run the following command to keep packagelist.txt in sync.  
`atom_pkg_update`



## Snippets

### Javascript

#### Debug/Console
[log] console.log  
`console.log(\'${1:crash}\',$1);$2`

[de] debugger  
`debugger;`


#### DOM
[cla] classList .add  
`${1:element}.classList.add(\'${2:class}\');`

[clr] classList .remove  
`${1:element}.classList.remove(\'${2:class}\');`

[clt] classList .toggle  
`${1:element}.classList.toggle(\'${2:class}\');`

[geta] getAttribute  
`${1:element}.getAttribute(\'${2:attr}\');`

[seta] setAttribute  
`${1:element}.setAttribute(\'${2:attr}\');`

[qs] querySelector  
`${1:document}.querySelector(\'${2:selector}\');`

[qsa] querySelectorAll  
`${1:document}.querySelectorAll(\'${2:selector}\');`

#### JSON
[jp] JSON.parse  
`JSON.parse(${1:obj});`

[js] JSON.stringify  
`JSON.stringify(${1:obj});`

#### Misc
[st] use strict  
`'use strict'`


### Vue
[vsf] Vue Single File Component   
