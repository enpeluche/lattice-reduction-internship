import os
import sys
from sage.all import *
from sage.repl.preparse import preparse # Indispensable pour comprendre la syntaxe "R.<x> = ..."

def load_from_dir(filepath, context=None):
    """
    Charge un fichier .sage, résout les chemins relatifs, 
    et injecte les variables dans le contexte donné.
    """
    filepath = os.path.abspath(filepath)
    directory, filename = os.path.split(filepath)
    
    original_dir = os.getcwd()
    
    try:
        if directory:
            os.chdir(directory)
            
        if context is None:
            load(filename)
            
        else:
            with open(filename, 'r') as f:
                code_sage = f.read()
            
            code_python = preparse(code_sage)
            
            exec(code_python, context)
                
    except Exception as e:
        raise e
        
    finally:
        os.chdir(original_dir)