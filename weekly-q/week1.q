years:1800 1900 1904 1969 1999 2000 2020 2022 2024 2048
isLeapYear:{$[0=x mod 100;0=x mod 400;0=x mod 4]}

isLeapYear each years
