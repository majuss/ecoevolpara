About this documentation
************************

This documentation should help the next admin and all users of the working group to control their software.

Most of the commands must be invoked with root-priveleages. You need to add your name to visudo or use :code:`su root`.

For a good Syntax reference see: `this <https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html>`_



How this documentation was made
*******************************

This documentation was build using `readthedocs.io <readthedocs.io>`_. And is written in restructured text (rst).
You can find the github repository `here <https://github.com/majuss/ecoevolpara>`_.

First see this `introduction-video <https://www.youtube.com/watch?v=oJsUvBQyHBs>`_.

A good documentation for .rst and sphinx_rtd_theme: `rst-documentation <https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html>`_.

Known issues
============

Very often an error will occur on the readthedocs.org/projects/ecoevolpara/builds/ website:

.. figure:: /appendix/pictures/git_submodule_error.png
   :width: 600px
   :alt: Git-Error

This may always occur due to an change in the sphinx_rtd_theme repository.

1. Ensure that there are no submodule sections in .git/config. If there are, remove them.
2. Do git rm --cached <path_to_submodule>. (git rm -r -f --cached latest/docs/_themes)


`Source <https://stackoverflow.com/questions/4185365/no-submodule-mapping-found-in-gitmodule-for-a-path-thats-not-a-submodule>`_



You still need help?
********************

Did you tried to turn it off and on again?

If this did not helped you should read the manpages of the program you are trying to use and google your problem several times.

