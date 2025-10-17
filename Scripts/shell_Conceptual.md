# Shell Scripts

1. **What is #!/bin/bash and why is it important?**

It’s called a shebang, which tells the system to execute the script using the /bin/bash shell interpreter. Without it, the script may run using another shell like sh.

2. **Difference between $* and $@ ?**

Both represent all positional parameters, but:
• $* → treats all arguments as a single string.
• $@ → treats each argument separately.


3. **What does $? mean?**

4. **What is the difference between > and >> ?**

5. **What is set -e and set -x?**