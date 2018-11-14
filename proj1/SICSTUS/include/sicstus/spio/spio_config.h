/* -*- buffer-read-only:t -*- 
This file is automatically generated, do not edit */

/* -*- Mode: C; -*- */
#ifndef SPIO_CONFIG_PUBLIC_H_COMMON_INCLUDED
#define SPIO_CONFIG_PUBLIC_H_COMMON_INCLUDED

#if ECLIPSE_CDT
#undef SP_NO_PRIVATE_CONFIG
#endif  /* ECLIPSE_CDT */

#if LOCAL_INCLUDES
/* [PM] 4.1.3+ unconditionally, so we no longer need HAVE_CONFIG_H */
#include "config.h"
#else  /* !LOCAL_INCLUDES */
#include <sicstus/config.h>
#endif  /* !LOCAL_INCLUDES */


/***************** Propagage from sicstus config.h to SPIO ****************************/
/* All things in public part of this file taken from SICStus config.h
   must be in the PUBLIC section of config.h! */

#if SP_BIGENDIAN
#define SPIO_BIGENDIAN 1
#else  /* !SP_BIGENDIAN */
#define SPIO_BIGENDIAN 0
#endif  /* !SP_BIGENDIAN */


/***************************************************************/
/* SPIO_DEBUG must be set in public part */
/* NOTE: The SPIO_DEBUG logic must be synced with config.h.$SPIO_PLATFORM etc */
#ifndef SPIO_DEBUG
#if SICSTUS_DBG
/* [PM] 4.2.1 NOTE: We must maintain binary compatibility between
   debug and non-debug builds and between SICSTUS_DBG/DBG/SPIO_DEBUG
   off and on. This is so that we can link non-debug (customer) code
   with a debug build of SICStus.
   
   So, be careful when using SICSTUS_DBG/DBG/SPIO_DEBUG (Only
   SPIO_DEBUG should be used in SPIO).
*/
#define SPIO_DEBUG 1
#endif  /* SICSTUS_DBG */
#endif  /* SPIO_DEBUG */

#ifndef SICSTUS_RELEASE_BUILD
#error "expected SICSTUS_RELEASE_BUILD to be defined here"
#endif  /* SICSTUS_RELEASE_BUILD */

#ifndef SPIO_DEBUG

#if !SICSTUS_RELEASE_BUILD
#define SPIO_DEBUG 1            /* this will tell spio_debug.h to enable SPIO_ASSERTIONS */

#ifndef SPIO_SOFT_ASSERTIONS
/* If SPIO_DEBUG was turned on because of non-release build (as
   opposed to a debug build) then we want to disable soft assertions
   since these should only be enabled during a full debug build, not
   in non-debug betas and similar). */
/* Do not let non-release turn on soft assertions (hard assertions _will_ be enabled, since we set SPIO_DEBUG above) */
#define SPIO_SOFT_ASSERTIONS 0
#endif  /* SPIO_SOFT_ASSERTIONS */

#endif  /* !SICSTUS_RELEASE_BUILD */
#endif  /* SPIO_DEBUG */

/***************************************************************/

#include "spio_version.h"

#endif  /* SPIO_CONFIG_PUBLIC_H_COMMON_INCLUDED */

#if !SP_NO_PRIVATE_CONFIG       /* Set in sicstus.h to prevent private defines */

#ifndef SPIO_CONFIG_INTERNAL_H_COMMON_INCLUDED
#define SPIO_CONFIG_INTERNAL_H_COMMON_INCLUDED



/* *** FEATURES *** */








#define SPIO_USE_WIDTH_TABLES 0 /* width tables (used for seeking on text streams) does not yet work */

#ifndef SPIO_USE_WORK_ITEMS
#define SPIO_USE_WORK_ITEMS 1
#endif  /* SPIO_USE_WORK_ITEMS */
#ifndef SPIO_USE_LOCK
#define SPIO_USE_LOCK 1
#endif  /* SPIO_USE_LOCK */
#ifndef SPIO_RELIABLE_INTERRUPTS
#define SPIO_RELIABLE_INTERRUPTS 1
#endif
#ifndef SPIO_AUTO_RESET_INTERRUPTS
#define SPIO_AUTO_RESET_INTERRUPTS 1
#endif  /* !SPIO_AUTO_RESET_INTERRUPTS */

#ifndef SPIO_GLOBAL_WORK_ITEM_LOCK_BIGLOCK
#define SPIO_GLOBAL_WORK_ITEM_LOCK_BIGLOCK 1
#endif  /* !SPIO_GLOBAL_WORK_ITEM_LOCK_BIGLOCK */

#endif  /* SPIO_CONFIG_INTERNAL_H_COMMON_INCLUDED */

#endif /* !SP_NO_PRIVATE_CONFIG */

/* -*- Mode: C; -*- */
#ifndef SPIO_CONFIG_PUBLIC_H_POSIX_INCLUDED
#define SPIO_CONFIG_PUBLIC_H_POSIX_INCLUDED

#define SPIO_UNIX 1

/* *** PUBLIC FEATURES: HEADERS *** */
/* These must go in the public section */
#define SPIO_HAVE_ERRNO_H 1
#define SPIO_HAVE_FCNTL_H 1
#define SPIO_HAVE_PTHREAD_H 1
#define SPIO_HAVE_SIGNAL_H 1
#define SPIO_HAVE_SYS_STAT_H 1
#define SPIO_HAVE_SYS_TYPES_H 1
#define SPIO_HAVE_SYS_SELECT_H 1
#define SPIO_HAVE_UNISTD_H 1
#define SPIO_HAVE_INTTYPES_H 1
#define SPIO_HAVE_TIME_H 1

/* *** PUBLIC FEATURES: TYPES *** */
#define SPIO_HAVE_SSIZE_T 1
#if SPIO_HAVE_UNISTD_H || SPIO_HAVE_INTTYPES_H
#define SPIO_HAVE_INTPTR_T 1

#if defined(__APPLE__)
/* intptr_t == long, also on 32-bit */
#define SPIO_INTPTR_T_IS_LONG 1
#endif  /* defined(__APPLE__) */

#endif	/* SPIO_HAVE_UNISTD_H || SPIO_HAVE_INTTYPES_H */
#if SPIO_HAVE_INTTYPES_H
#define SPIO_HAVE_UINTPTR_T 1
#endif	/* SPIO_HAVE_INTTYPES_H */

#if !SPIO_NO_PUBLIC_INCLUDE_LIMITS_H
#include <limits.h> /* WORD_BIT, LONG_BIT */
#endif /* !SPIO_NO_PUBLIC_INCLUDE_LIMITS_H */

/* 4.2.2 As POSIX WORD_BIT, LONG_BIT */
#define SPIO_WORD_BIT WORD_BIT
#define SPIO_LONG_BIT LONG_BIT
/* [PM] 4.2.2 We assume that all POSIX systems use sizeof(long) ==
   sizeof(void*) */
#define SPIO_PTR_BIT LONG_BIT

#endif  /* SPIO_CONFIG_PUBLIC_H_POSIX_INCLUDED */

#if !SP_NO_PRIVATE_CONFIG       /* Set in sicstus.h to prevent private defines */

#ifndef SPIO_CONFIG_INTERNAL_H_POSIX_INCLUDED
#define SPIO_CONFIG_INTERNAL_H_POSIX_INCLUDED

#include <unistd.h>             /* needed for feature tests below */

#ifndef SP_ANDROID
#error "Expected SP_ANDROID to be defined, possibly false, here."
#endif  /* SP_ANDROID */

#ifndef SPIO_ANDROID
#ifdef SP_ANDROID
#define SPIO_ANDROID SP_ANDROID
#endif  /* SP_ANDROID */
#endif  /* !SPIO_ANDROID */
#if !!(SPIO_ANDROID+0) != !!(ANDROID+0)
#if SPIO_ANDROID
#error "[PM] 4.1.3+ SPIO_ANDROID && !ANDROID"
#else  /* ANDROID */
#error "[PM] 4.1.3+ !SPIO_ANDROID && ANDROID"
#endif
#endif  /* SPIO_ANDROID != ANDROID */

/* *** HEADERS *** */

#if defined(__APPLE__)
/* since Mac OS X 10.5 */
#define SPIO_HAVE_EXECINFO_H 1
#endif /* __APPLE__ */

/* *** FEATURES *** */

#define SPIO_USE_PTHREADS 1

#if !defined(SPIO_USE_AIO)
/* 

   UPDATE:
      SPRM 9823 Force use of threads for now.

      AIO performance (with SIGEV_NONE) was not significantly better
      than using threads (once the read buffer was made large
      enough). For this reason and the fact that the AIO code does
      not implement select()-functionality and the fact that AIO is a
      new OS feature that may not be available everywhere (and that I
      did not get to work on Darwin 8.8.1 x86_64).

   UPDATE: We could use SIGEV_THREAD to make aio completion set
   stream events.

   There does not seem to be a good way to use select to wait on
   completion of ordinary file descriptors and, at the same time, wait
   for completion of one or more AIO request. The only way seem to be
   to spawn a thread that uses aio_suspend but then we may as well use
   a thread with pread/pwrite directly.

   We may do better eventually if we postpone the aio_suspend thread
   until (and if) someone actually does select on the file. On the
   other hand, the current version of spio_async_suspend_unix does a
   polling loop with aio_suspend and a short timeout which is ugly.

   Also, Solaris 10 (MacOS X and BSD has kqueue?) has new more generic features
   for waiting on events. Perhaps these can wait for both fds and AIO.

*/
#define SPIO_USE_AIO 0          /* see SPRM 9823 comment above */
#endif  /* !SPIO_BETA_VERSION */

#if SPIO_USE_AIO
#error "[PM] 4.0 Resolve selectable_fd and AIO issues "
#endif  /* SPIO_USE_AIO */


#ifndef SPIO_USE_AIO
/* only if aio.h et al should be used */
#define SPIO_USE_AIO 1
#endif  /* !SPIO_USE_AIO */

#define SPIO_USE_SPIO_EVENT_PIPE 1

#define SPIO_TASK_PTHREAD_CANCEL_HANDLING 1


#ifndef SPIO_HAVE_BROKEN_CANCELLATION_POINTS
#ifdef SP_HAVE_BROKEN_CANCELLATION_POINTS
#define SPIO_HAVE_BROKEN_CANCELLATION_POINTS SP_HAVE_BROKEN_CANCELLATION_POINTS
#endif  /* SP_HAVE_BROKEN_CANCELLATION_POINTS */
#endif  /* SPIO_HAVE_BROKEN_CANCELLATION_POINTS */

#if !defined(SPIO_HAVE_BROKEN_CANCELLATION_POINTS)
#if defined(__APPLE__)
/*
Google for
  "pthread_cancel" bug darwin Per Mildner
to see how pthread_cancel does not work on Mac OS X/Darwin
(broken at least to 10.5. Seems to be fixed in Mac OS X 10.6 Snow Leopard)
*/
#define SPIO_HAVE_BROKEN_CANCELLATION_POINTS 1
#endif  /* defined(__APPLE__) */
#endif  /* !defined(SPIO_HAVE_BROKEN_CANCELLATION_POINTS) */

#ifndef SPIO_AVOID_PTHREAD_CANCEL
#if SP_AVOID_PTHREAD_CANCEL
#define SPIO_AVOID_PTHREAD_CANCEL 1
#endif  /* SP_AVOID_PTHREAD_CANCEL */
#endif  /* SPIO_AVOID_PTHREAD_CANCEL */

#ifdef __APPLE__

/* [PM] 4.1.3 Mac OS X 10.5.8 (and perhaps Mac OS X 10.6.4, need to
   recheck) seems to have the problem that pthread_cancel can take
   effect in the targeted thread even though it has cancellation state
   PTHREAD_CANCEL_DISABLE. This cancels thread cleanup and leaves
   mutexes locked by a non-existing thread causing deadlock.

   This is mainly a problem in spio_layer_threaddevice.c and the
   following variables (which can all be overridden, on all
   pthreads-platforms, with like-named system properties) makes an
   attempt to avoid using pthread_cancel() if at all possible.
*/
#ifndef SPIO_AVOID_PTHREAD_CANCEL
#define SPIO_AVOID_PTHREAD_CANCEL 1
#endif  /* !SPIO_AVOID_PTHREAD_CANCEL */

#if 0
#ifndef SPIO_THREAD_KILL_DELAY_DEFAULT
#define SPIO_THREAD_KILL_DELAY_DEFAULT 10
#endif  /* SPIO_THREAD_KILL_DELAY_DEFAULT */
#ifndef SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT
#define SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT 20
#endif  /* SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT */
#ifndef SPIO_PTHREAD_CANCEL_DELAY_DEFAULT
#define SPIO_PTHREAD_CANCEL_DELAY_DEFAULT 50
#endif  /* SPIO_PTHREAD_CANCEL_DELAY_DEFAULT */
#endif  /* 0 */


/* [PM] 4.3.4 Instead we avoid OSMemoryBarrier() completely if
   stdatomic.h is available on macOS, see spio_memops.h. */
#if 0
#if ! defined (OSATOMIC_USE_INLINED)
/* [PM] 4.3.4 OSMemoryBarrier is deprecated in macOS 10.12.

 /usr/include/libkern/OSAtomic.h:
 "Define OSATOMIC_USE_INLINED=1 to get inline implementations of the OSAtomic interfaces in terms of the <stdatomic.h> primitives."
*/
#define OSATOMIC_USE_INLINED 1
#endif	/* ! defined (OSATOMIC_USE_INLINED) */
#endif	/* 0 */

#endif  /* __APPLE__ */


#if SPIO_AVOID_PTHREAD_CANCEL
/* [PM] 4.1.3 The specific values were experimentally determined on
   Mac OS X and can probably be improved for other platforms (and
   system speeds) */

#ifndef SPIO_THREAD_KILL_DELAY_DEFAULT
#define SPIO_THREAD_KILL_DELAY_DEFAULT 10
#endif  /* SPIO_THREAD_KILL_DELAY_DEFAULT */
#ifndef SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT
#define SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT 20
#endif  /* SPIO_THREAD_KILL_SCHED_YIELD_DEFAULT */
#ifndef SPIO_PTHREAD_CANCEL_DELAY_DEFAULT
#define SPIO_PTHREAD_CANCEL_DELAY_DEFAULT 50
#endif  /* SPIO_PTHREAD_CANCEL_DELAY_DEFAULT */

#endif  /* SPIO_AVOID_PTHREAD_CANCEL */

#ifndef SPIO_DRY_RUN_PTHREAD_CANCEL
#if __GLIBC__
/* [PM] 4.1.3 Work around "libgcc_s.so.1 must be installed for
   pthread_cancel to work" (glibc aborts when no file descriptors
   available) */
#define SPIO_DRY_RUN_PTHREAD_CANCEL 1
#endif  /* __GLIBC__ */
#endif  /* SPIO_DRY_RUN_PTHREAD_CANCEL */

#ifndef SPIO_USE_WAITID
#if __APPLE__
/* [PM] 4.0.2+ waitid is still broken in Mac OS X 10.5.1/Darwin 9.1.0/Leopard */
/* [PM] 4.1 waitid still broken in Mac OS X 10.6.1/Darwin 10.0.0/Snow Leopard */
/* [PM] 4.1 If you enable SPIO_USE_WAITID you will get a failure in
   Suite/process wait_test. The (a?) problem is that waitid does not
   return the information about when a process has been killed, see
   spio_unix.c for a partial workaround (which is only used if
   SPIO_USE_WAITID is true).

   Also, note the following bug-report (against 10.5.?, I think) that
   gives yet another reason for not using waitid on Mac OS X:

     // We're disabling usage of waitid in Mac OS X because it doens't work for us:
     // a parent process hangs on waiting while a child process is already a zombie.
     // See http://code.google.com/p/v8/issues/detail?id=401.
*/
#define SPIO_USE_WAITID 0
#endif  /* __APPLE__ */
#endif /* !SPIO_USE_WAITID */

#ifndef SPIO_HAVE_TASK_CANCEL_EVENT

/* when cancellations points does not work (i.e. MacOS X/Darwin < 10.6) we need an event to tell us task is cancelled */
#if SPIO_HAVE_BROKEN_CANCELLATION_POINTS
#define SPIO_HAVE_TASK_CANCEL_EVENT 1
#endif  /* SPIO_HAVE_BROKEN_CANCELLATION_POINTS */

#endif  /* SPIO_HAVE_TASK_CANCEL_EVENT */

/* *** MORE HEADERS *** */

#ifndef SPIO_HAVE_LANGINFO_H
#ifdef HAVE_LANGINFO_H
#define SPIO_HAVE_LANGINFO_H HAVE_LANGINFO_H
#else  /* !HAVE_LANGINFO_H */
#define SPIO_HAVE_LANGINFO_H 1  /* SUSV3 XSI */
#endif  /* !HAVE_LANGINFO_H */
#endif  /* !SPIO_HAVE_LANGINFO_H */

#ifndef SPIO_HAVE_POLL
#ifdef HAVE_POLL
#define SPIO_HAVE_POLL HAVE_POLL
#else  /* !HAVE_POLL */
#define SPIO_HAVE_POLL 1
#endif  /* !HAVE_POLL */
#endif  /* !SPIO_HAVE_POLL */

#ifndef SPIO_HAVE_POLL_H
#ifdef HAVE_POLL_H
#define SPIO_HAVE_POLL_H HAVE_POLL_H
#else  /* !HAVE_POLL_H */
#define SPIO_HAVE_POLL_H 1
#endif  /* !HAVE_POLL_H */
#endif  /* !SPIO_HAVE_POLL_H */

/* Propagate SP_POLL_BROKEN_FOR_DEVICES -> SPIO_POLL_BROKEN_FOR_DEVICES */
#ifndef SPIO_POLL_BROKEN_FOR_DEVICES
#ifdef SP_POLL_BROKEN_FOR_DEVICES
/* [PM] 4.1.3 On Mac OS X (at least <= 10.6.3) poll() is broken for
   devices we need to fall back to using select().
   See for instance <http://bugs.python.org/issue5154>.
*/
/* == 1 to test at initialization, > 1 to assume poll is broken for devices. */
#define SPIO_POLL_BROKEN_FOR_DEVICES SP_POLL_BROKEN_FOR_DEVICES
#endif  /* SP_POLL_BROKEN_FOR_DEVICES */
#endif  /* !SPIO_POLL_BROKEN_FOR_DEVICES */

/* Propagate SP_POLL_BROKEN_FOR_FIFOS -> SPIO_POLL_BROKEN_FOR_FIFOS */
#ifndef SPIO_POLL_BROKEN_FOR_FIFOS
#if SP_POLL_BROKEN_FOR_FIFOS
/* [PM] 4.1.3 On Mac OS X (at least <= 10.5.8 but not Mac OS X 10.6.4)
   poll() is broken for fifos.
   
   Also on Linux r2d2 2.6.24-28-generic #1 SMP Sat Jul 31 16:10:32 UTC
   2010 i686 GNU/Linux (where poll() on a fifo with no writer will
   block which is standards-violating but non-fatal behavior.
   
   but not on

   Linux zjuk.sics.se 2.6.9-89.0.28.EL #1 Thu Jul 22 18:04:14 EDT 2010
   x86_64 x86_64 x86_64 GNU/Linux

*/
#define SPIO_POLL_BROKEN_FOR_FIFOS 1
#endif  /* SP_POLL_BROKEN_FOR_FIFOS */
#endif  /* !SPIO_POLL_BROKEN_FOR_FIFOS */

#if SPIO_HAVE_BROKEN_CANCELLATION_POINTS
#define SPIO_NEED_WAIT_ON_DEVICES 1
#endif /* SPIO_HAVE_BROKEN_CANCELLATION_POINTS */

#ifndef SPIO_USE_POLL
#if SPIO_HAVE_POLL
#if SP_DONT_USE_POLL
#define SPIO_USE_POLL 0
#elif SP_USE_POLL
#define SPIO_USE_POLL 1
#endif  /* SP_USE_POLL */
#endif  /* SPIO_HAVE_POLL */
#endif  /* SPIO_USE_POLL */

#ifndef SPIO_USE_POLL
#if (SPIO_NEED_WAIT_ON_DEVICES && SPIO_POLL_BROKEN_FOR_DEVICES)
#define SPIO_USE_POLL 0
#endif /* (SPIO_NEED_WAIT_ON_DEVICES && SPIO_POLL_BROKEN_FOR_DEVICES) */
#endif /* !SPIO_USE_POLL */

/* [PM] 4.1.3 use poll() if available (SPRM 11822) and not explicitly disabled */
#ifndef SPIO_USE_POLL
#if SPIO_HAVE_POLL
#define SPIO_USE_POLL 1
#endif /* SPIO_HAVE_POLL */
#endif /* !SPIO_USE_POLL */


/* [PM] 4.1.3 Only use select if we can not use poll() */
#ifndef SPIO_USE_SELECT
#if !SPIO_USE_POLL
#define SPIO_USE_SELECT 1
#endif  /* SPIO_USE_POLL */
#endif  /* !SPIO_USE_SELECT */


/* 
   For now disable AIO completely unless it is explicitly requested
 */
#ifndef SPIO_HAVE_AIO
#if !SPIO_USE_AIO
#define SPIO_HAVE_AIO 0
#endif /* !SPIO_USE_AIO */
#endif /* !SPIO_HAVE_AIO */

#ifdef SPIO_HAVE_AIO
#if !SPIO_HAVE_AIO              /* explicitly disabled (e.g. AIX 5.1) */
#define SPIO_HAVE_AIO_H 0       /* pretend we do not have it if we are not going to use it */
#endif /* !SPIO_HAVE_AIO */
#endif /* SPIO_HAVE_AIO */

#ifndef SPIO_HAVE_AIO_H
#define SPIO_HAVE_AIO_H 1       /* assume POSIX/UNIX98 compatible*/
#endif /* !SPIO_HAVE_AIO_H */

#if SPIO_HAVE_AIO_H
#ifndef SPIO_HAVE_AIO
#define SPIO_HAVE_AIO 1
#endif /* !SPIO_HAVE_AIO */
#endif /* SPIO_HAVE_AIO_H */

#if _POSIX_SPAWN+0 > 0
#define SPIO_HAVE_SPAWN_H 1
#endif  /* _POSIX_SPAWN */

/* AIX 5.1 have aio.h but incompatible aio routines (I believe AIX 5.3 has POSIX compliant AIO routines) */
#ifndef SPIO_HAVE_AIO
#if SPIO_HAVE_AIO_H
#define SPIO_HAVE_AIO 1
#else  /* !SPIO_HAVE_AIO_H */
#define SPIO_HAVE_AIO 0
#endif /* !SPIO_HAVE_AIO_H */
#endif /* SPIO_HAVE_AIO */

/* *** TYPES *** */

#define SPIO_CDECL              /* empty */

/* *** FUNCTIONS *** */

#ifdef HAVE_PROC_SELF_FD
#define SPIO_HAVE_PROC_SELF_FD HAVE_PROC_SELF_FD
#else
#define SPIO_HAVE_PROC_SELF_FD 0
#endif

#ifdef HAVE_DIRFD
#define SPIO_HAVE_DIRFD HAVE_DIRFD
#else
#define SPIO_HAVE_DIRFD 0
#endif  /* HAVE_DIRFD */

#ifdef HAVE_WAITID
#define SPIO_HAVE_WAITID HAVE_WAITID
#else  /* !HAVE_WAITID */
#define SPIO_HAVE_WAITID 1      /* SUSv3 */
#endif  /* !HAVE_WAITID */

#ifdef HAVE_CLOSEFROM
#define SPIO_HAVE_CLOSEFROM HAVE_CLOSEFROM
#else
#define SPIO_HAVE_CLOSEFROM 0
#endif

#ifdef HAVE_GETADDRINFO
#define SPIO_HAVE_GETADDRINFO HAVE_GETADDRINFO
#else
#define SPIO_HAVE_GETADDRINFO 1 /* SUSv3 */
#endif

#ifdef HAVE_NL_LANGINFO
#define SPIO_HAVE_NL_LANGINFO HAVE_NL_LANGINFO
#else
#define SPIO_HAVE_NL_LANGINFO SPIO_HAVE_LANGINFO_H /* assume the header defines it */
#endif

#ifdef HAVE_SETLOCALE
#define SPIO_HAVE_SETLOCALE HAVE_SETLOCALE
#else
#define SPIO_HAVE_SETLOCALE 1   /* ISO C */
#endif

#ifdef HAVE_GET_CURRENT_DIR_NAME
#define SPIO_HAVE_GET_CURRENT_DIR_NAME HAVE_GET_CURRENT_DIR_NAME
#else
#define SPIO_HAVE_GET_CURRENT_DIR_NAME 0
#endif  /* HAVE_GET_CURRENT_DIR_NAME */

#ifdef HAVE_GETCWD
#define SPIO_HAVE_GETCWD HAVE_GETCWD
#else
#define SPIO_HAVE_GETCWD 0
#endif  /* HAVE_GETCWD */

#ifdef HAVE_PTHREAD_TESTCANCEL
#define SPIO_HAVE_PTHREAD_TESTCANCEL HAVE_PTHREAD_TESTCANCEL
#else  /* !defined HAVE_PTHREAD_TESTCANCEL */
/* [PM] 4.1.3+ This is only false on Android */
#if ANDROID
#error "Expected HAVE_PTHREAD_TESTCANCEL to be defined, possibly false, here"
#endif  /* ANDROID */
#define SPIO_HAVE_PTHREAD_TESTCANCEL 1
#endif  /* !defined HAVE_PTHREAD_TESTCANCEL */

#define SPIO_HAVE_PTHREAD_SETCANCELSTATE SPIO_HAVE_PTHREAD_TESTCANCEL
#define SPIO_HAVE_PTHREAD_CANCEL SPIO_HAVE_PTHREAD_TESTCANCEL


#ifdef HAVE_GETPWUID
#define SPIO_HAVE_GETPWUID HAVE_GETPWUID
#else  /* !defined HAVE_GETPWUID */
/* [PM] 4.1.3+ This is only false on Android */
#if ANDROID
#error "Expected ANDROID to be false here"
#endif  /* ANDROID */
#define SPIO_HAVE_GETPWUID 1
#endif  /* ! defined HAVE_GETPWUID */

#ifdef HAVE_GETPWUID_R
#define SPIO_HAVE_GETPWUID_R HAVE_GETPWUID_R
#else  /* !define HAVE_GETPWUID_R */
/* [PM] 4.1.3+ This is only false on Android */
#if ANDROID
#error "Expected ANDROID to be false here"
#endif  /* ANDROID */
#define SPIO_HAVE_GETPWUID_R 1
#endif  /* !defined HAVE_GETPWUID_R */

#ifdef HAVE_GETGRGID
#define SPIO_HAVE_GETGRGID HAVE_GETGRGID
#else  /* !defined HAVE_GETGRGID */
/* [PM] 4.1.3+ This is only false on Android */
#if ANDROID
#error "Expected ANDROID to be false here"
#endif  /* ANDROID */
#define SPIO_HAVE_GETGRGID 1
#endif  /* ! defined HAVE_GETGRGID */

#ifdef HAVE_GETGRGID_R
#define SPIO_HAVE_GETGRGID_R HAVE_GETGRGID_R
#else  /* !define HAVE_GETGRGID_R */
/* [PM] 4.1.3+ This is only false on Android */
#if ANDROID
#error "Expected ANDROID to be false here"
#endif  /* ANDROID */
#define SPIO_HAVE_GETGRGID_R 1
#endif  /* !defined HAVE_GETGRGID_R */



#endif /* !SPIO_CONFIG_INTERNAL_H_POSIX_INCLUDED */

#endif  /* !SP_NO_PRIVATE_CONFIG */