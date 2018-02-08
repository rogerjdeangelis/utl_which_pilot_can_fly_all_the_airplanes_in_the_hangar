Which pilot can fly all the airplanes in the hangar

same results in WPS and SAS

see
https://communities.sas.com/t5/Base-SAS-Programming/road-name-in-all-the-city/m-p/435223

Ksharp profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/18408

This is a variation of 'indentify the pilot who can fly all the planes in the hanger'

also see
https://msbiskills.com/2015/04/06/t-sql-query-airplanes-and-pilots-puzzle/



INPUT
=====

 WORK.HAVE total obs=11

    PILOT        PLANE

   Higgins    B-52Bomber
   Higgins    F-14Fighter
   Jones      B-52Bomber
   Jones      F-14Fighter
   Smith      B-1Bomber
   Smith      B-52Bomber
   Smith      F-14Fighter
   Wilson     B-1Bomber
   Wilson     B-52Bomber
   Wilson     F-14Fighter
   Wilson     F-17Fighter


PROCESS (All the code)
======================

   proc sql;
      select
         *
     from
         have
     group by
        pilot
     having
        count(distinct plane) eq
        (select
           count(distinct plane)
         from
           have
        )
    ;quit;


OUTPUT
======

   PILOT     PLANE
   -----------------------
   Wilson    F-17Fighter
   Wilson    F-14Fighter
   Wilson    B-52Bomber
   Wilson    B-1Bomber

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
 informat pilot $8. plane $13.;
 input pilot plane;
cards4;
Higgins B-52Bomber
Higgins F-14Fighter
Jones B-52Bomber
Jones F-14Fighter
Smith B-1Bomber
Smith B-52Bomber
Smith F-14Fighter
Wilson B-1Bomber
Wilson B-52Bomber
Wilson F-14Fighter
Wilson F-17Fighter
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

proc sql;
   select
      *
  from
      have
  group by
     pilot
  having
     count(distinct plane) eq
     (select
        count(distinct plane)
      from
        have
     )
 ;quit;

%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
proc sql;
   select
      *
  from
      wrk.have
  group by
     pilot
  having
     count(distinct plane) eq
     (select
        count(distinct plane)
      from
        wrk.have
     )
 ;quit;
run;quit;
');

