/*Data Exploration for sashelp.cars*/


/*  What variables are in sashelp.cars */
title 'Variable Listing for sashelp.cars';
ods select Variables;
proc contents data=sashelp.cars;
run;
ODS default;
title;

/* Which fields have missing values */
/* Mazdas have Rotary 0 cylinders therefore cylinders is null*/
title 'Which Fields Have Missing Values';
proc means data=sashelp.cars NMISS;
run;


/*  Range for mileage and price */
title 'Range for Mileage and Price';
proc means data=sashelp.cars noobs N mean min max  maxdec=2;
var mpg_city mpg_highway msrp;
run;

/* which car get the best mileage in the city */
title 'Best Mileage in the City';
proc sql;
select make, model, mpg_city
from sashelp.cars
where mpg_city in (select max(mpg_city) from sashelp.cars);
quit;
title;

/* which car get the best mileage on the highway */

title 'Best Mileage on the highway';
proc sql;
select make, model, mpg_highway
from sashelp.cars
where mpg_highway in (select max(mpg_highway) from sashelp.cars);
quit;

/*  What are the 10 cheapest cars */
proc rank data=sashelp.cars out=cheapest_car;
var msrp;
ranks msrp_cheapest;
run;


proc sort data=cheapest_car;
by msrp;

title '10 Cheapest Cars';
proc print data=cheapest_car;
where msrp_cheapest <= 10;
var make model type origin msrp msrp_cheapest;
run;
title;

/* What are the 10 most expensive cars */
proc rank data=sashelp.cars descending out=expensive_car;
var msrp;
ranks msrp_expensive;
run;

proc sort data=expensive_car;
by msrp_expensive;

title '10 Most Expensive Cars';
proc print data=expensive_car;
where msrp_expensive <= 10;
var make model type origin msrp msrp_expensive;
run;
title;

/* Car Pricing Summary */
Title 'Car Pricing Summary By Type';
proc means data=sashelp.cars nonobs N min mean max range;
var msrp;
class type;
run;
title;


Title 'Car Pricing Summary By Origin';
proc means data=sashelp.cars nonobs N min mean max range;
var msrp;
class origin;
run;
title;