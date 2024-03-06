LIBS=foo bar baz foobaz
LDARGS=-Wl,-rpath -ldl -Wl,-melf_x86_64 -rdynamic -fuse-ld=gold -lnsl -pthread

${info i is [${i}]}

# := Means we are resolving variables on the r side

# We can't include commas in make sub commands, so, we need to put
# comma in a variable.
comma:=,
# Multiple filters are space separated
LDARGS_Filter+=$(filter-out -Wl$(comma)-melf_x86_64 -fuse-ld=gold,$(LDARGS))
LDARGS_Subst+=$(subst -Wl$(comma)-melf_x86_64 ,,$(LDARGS))
LIBS_PREPEND := $(patsubst %, -l:%,$(LIBS))

${info $$LDARGS is [${LDARGS}]}
${info $$LDARGS_Subst is [${LDARGS_Subst}]}
${info $$LDARGS_Filter is [${LDARGS_Filter}]}
${info $$LIBS_PREPEND is [${LIBS_PREPEND}]}

# Writing to file
$(file > test.txt,$(LDARGS))

@mkdir test

# If we want to exit a makefile early we can  generate an error message
$(error Exiting now...)
