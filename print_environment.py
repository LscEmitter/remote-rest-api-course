import os
import sys

print(f"Hello, I'm on machine ", end="")
sys.stdout.flush()
os.system('uname -n')


def get_base_prefix_compat():
    """Get base/real prefix, or sys.prefix if there is none."""
    return getattr(sys, "base_prefix", None) or getattr(sys, "real_prefix", None) or sys.prefix

def in_virtualenv():
    return get_base_prefix_compat() != sys.prefix

if in_virtualenv():
    print("\nThis is my venv environment path (sys.prefix):", sys.prefix)
else:
    print("\nI am not in a virtual path.")
