#!/bin/bash
assert() {
    expected="$1"
    input="$2"

    ./mcc "$input" > tmp.s
    cc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

assert 0 "0;"
assert 42 "42;"
assert 21 "5+20-4;"
assert 24 "5 + 20 - 1;"
assert 47 '5+6*7;'
assert 15 '5*(9-6);'
assert 4 '(3+5)/2;'
assert 10 '-10++20;'
assert 1 "1== 1;"
assert 0 " 2 == 3 ;"
assert 0 "1 != 1;"
assert 1 "1 < 2;"
assert 1 "1 <= 1;"
assert 1 "2 > 1;"
assert 1 "1 >= 1;"
assert 4 "a = 3 + 3; b = 5 - 1;"
assert 7 "z = 3 + 3;a = 2 - 1;2 + z - a ;"
assert 8 "abcd = 8;"

echo OK