import os
from ranger.api.commands import Command

HOME = os.getenv("HOME")

class sshfs(Command):

    def execute(self):
        assert isinstance(self.arg(1), str)
        assert isinstance(self.arg(2), str)
        assert isinstance(self.arg(3), str)
        os.system("sshfs "+self.arg(1)+"@"+self.arg(2)+":"+self.arg(3)+" "+HOME+"/.ranger-sshfs")
        
class sshfsu(Command):

    def execute(self):
        os.system("fusermount3 -u "+HOME+"/.ranger-sshfs")
