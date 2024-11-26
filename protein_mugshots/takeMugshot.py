# yanked from pymol wiki - https://pymolwiki.org/index.php/VisLoad 
import os
from os import path
from pymol import cmd

def takeMugshot(filename, object=None, *args, **kwargs):
  if object==None:
    object = os.path.basename(filename).split(".")[0]
  cmd.set("suspend_updates")
  try:
    cmd.load(filename,'prot')
    cmd.run("./AF-style_viz.pml")
    cmd.png("./"+str(os.path.basename(filename).split(".")[0])+".png")
    cmd.delete('prot')
  finally:
    cmd.set("suspend_updates", "off")

cmd.extend("takeMugshot", takeMugshot)
