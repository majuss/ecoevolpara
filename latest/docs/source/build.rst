*******************************
How this documentation was made
*******************************

This documentation was build using `readthedocs.io <readthedocs.io>`_. And is written in restructured text (rst).
You can find the github repository `here <https://github.com/majuss/ecoevolpara>`_.

First see this `introduction-video <https://www.youtube.com/watch?v=oJsUvBQyHBs>`_.

A good documentation for .rst and sphinx_rtd_theme: `.rst-documentation <https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html
>`_

Known issues
============

Very often an error will occur on the readthedocs.org/projects/ecoevolpara/builds/ website:
======================================================
.. figure:: /appendix/pictures/git_submodule_error.png
   :width: 600px
   :alt: Git-Error
======================================================

This may always occur due to an change in the sphinx_rtd_theme repository.

1. Ensure that there are no submodule sections in .git/config. If there are, remove them.
2. Do git rm --cached <path_to_submodule>.

`Source <https://stackoverflow.com/questions/4185365/no-submodule-mapping-found-in-gitmodule-for-a-path-thats-not-a-submodule>`_