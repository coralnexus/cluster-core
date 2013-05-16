
#-----------------------------------------------------------------------------
# Defaults

import 'default.pp'
import 'default/*.pp'
include core::default

#---

global_options('all', {
  search => [ 'core::default' ]
})

#-----------------------------------------------------------------------------
# Profiles

import 'profiles/*.pp'
