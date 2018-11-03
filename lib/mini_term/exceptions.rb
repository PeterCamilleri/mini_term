# coding: utf-8

# The abstract base exception for mini term.
class MiniTermError < StandardError; end

# The exception raised when something is really messed up.
class MiniTermWTF < MiniTermError; end

# The exception raised due to strictness.
class MiniTermStrict < MiniTermError; end

# The exception raised when no keyboard mapping is found.
class MiniTermNoMap < MiniTermError; end

# The exception raised when the keyboard mapping is invalid.
class MiniTermKME < MiniTermError; end
