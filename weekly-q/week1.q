/ 2020.01.06
years:1800 1804 1900 1984 1999 2000 2020 2022 2024 2048 2064;

isLeapYear0:{0<>mod[;2] sum 0=x mod\: 4 100 400};
isLeapYear1:{$[0=x mod 100;0=x mod 400;0=x mod 4]};
isLeapYear2:{(0=x mod 400)|(0=x mod 4)&(0<>x mod 100)};

isLeapYear0 each years
isLeapYear1 each years
isLeapYear2 each years
