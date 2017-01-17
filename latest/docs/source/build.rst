*******************************
How this documentation was made
*******************************

This documentation was build using `readthedocs.io <readthedocs.io>`_. And is written in restructured text (rst).
You can find the github repository `here <https://github.com/majuss/ecoevolpara>`_.

https://www.youtube.com/watch?v=oJsUvBQyHBs

https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html

Very often an error will occur on the readthedocs.org/projects/ecoevolpara/builds/ website:


.. figure:: /appendix/pictures/git_submodule_error.png
   :width: 600px
   :alt: Sphinx Neo-Hittite

This may always occur due to an change in the sphinx_rtd_theme repository.

INSERT PICTURE HERE



1. Ensure that there are no submodule sections in .git/config. If there are, remove them.
2. Do git rm --cached <path_to_submodule>.


: 1 git clone error output: No submodule mapping found in .gitmodules for path 'latest/docs/_themes/sphinx_rtd_theme'

https://stackoverflow.com/questions/4185365/no-submodule-mapping-found-in-gitmodule-for-a-path-thats-not-a-submodule