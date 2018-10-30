# coding: utf-8

# The exception raised when something is really messed up.
class MiniTermInternal < RuntimeError; end

# The exception raised when no keyboard mapping is found.
class MiniTermNoMap < RuntimeError; end

# The exception raised when the keyboard mapping is invalid.
class MiniTermKME < RuntimeError; end
