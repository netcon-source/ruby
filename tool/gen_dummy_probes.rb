#!/usr/bin/ruby
# -*- coding: us-ascii -*-

text = ARGF.read
text.gsub!(/^(?!#)(.*)/){$1.upcase}

# remove the pragma declarations
text.gsub!(/^#pragma.*$/, '')

# replace the provider section with the start of the header file
text.gsub!(/PROVIDER RUBY \{/, "#ifndef\t_PROBES_H\n#define\t_PROBES_H\n#define DTRACE_PROBES_DISABLED 1\n")

# finish up the #ifndef sandwich
text.gsub!(/\};/, "#endif\t/* _PROBES_H */")

text.gsub!(/__/, '_')

text.gsub!(/\([^,)]+\)/, '(arg0)')
text.gsub!(/\([^,)]+,[^,)]+\)/, '(arg0, arg1)')
text.gsub!(/\([^,)]+,[^,)]+,[^,)]+\)/, '(arg0, arg1, arg2)')
text.gsub!(/\([^,)]+,[^,)]+,[^,)]+,[^,)]+\)/, '(arg0, arg1, arg2, arg3)')
text.gsub!(/\([^,)]+,[^,)]+,[^,)]+,[^,)]+,[^,)]+\)/, '(arg0, arg1, arg2, arg3, arg4)')

text.gsub!(/ *PROBE ([^\(]*)(\([^\)]*\));/, "#define RUBY_DTRACE_\\1_ENABLED() 0\n#define RUBY_DTRACE_\\1\\2\ do \{ \} while\(0\)")
print text

