AC_DEFUN([BBDB_WITH_VM],
[
AC_ARG_WITH([vm-dir],
AS_HELP_STRING([--with-vm-dir=DIR], [where to find VM's lisp directory]),
# if VM was requested, make sure we have access to the source
[if test "x$with_vm_dir" != xno -a "x$with_vm_dir" != "x"; then
    AC_MSG_CHECKING([for VM files])
    # convert path to absolute and canonicalize it.
    VMDIR=$(${EMACS} -batch --quick -eval "(message \"%s\" (expand-file-name \"${with_vm_dir}\"))" 2>&1)
    BBDB_VM=$(${EMACS} -batch --quick --directory=${VMDIR} -eval "(if (or (locate-library \"vm-autoload\") (locate-library \"vm-autoloads\")) (message \"vm\"))" 2>&1)
    if test "x$BBDB_VM" = "x"; then
       AC_MSG_ERROR([*** VM's vm-autoloads.el must exist in directory passed to `--with-vm-dir'.])
    fi
    AC_MSG_RESULT($VMDIR)
    AM_ELCFLAGS=--directory=$VMDIR
    AC_SUBST([AM_ELCFLAGS])
 fi])
])
