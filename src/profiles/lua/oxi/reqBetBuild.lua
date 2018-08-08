-- HTTP method, body, and adding a header

xml_body =[[
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE oxip SYSTEM "oxip.dtd">
<oxip version="6.0">
    <request>
        <reqClientAuth returnToken="N">
            <user>oxiapi</user>
            <password>oxiapi</password>
        </reqClientAuth>
        <reqBetBuild returnOffers="Y">
            <token>{{token}}</token>
            <errorDetail>ALL</errorDetail>
            <channel>M</channel>
            <bet>
                <betNo>1</betNo>
                <leg>
                    <legNo>1</legNo>
                    <legSort>IM</legSort>
                    <legType>W</legType>
                    <part>
                        <partNo>1</partNo>
                        <outcome>390623474</outcome>
                        <partSort>HH</partSort>
                        <priceType>L</priceType>
                        <priceNum>10000</priceNum>
                        <priceDen>1000</priceDen>
                    </part>
                    <part>
                        <partNo>2</partNo>
                        <outcome>390626902</outcome>
                        <partSort>HL</partSort>
                        <priceType>L</priceType>
                        <priceNum>10000</priceNum>
                        <priceDen>1000</priceDen>
                        <handicap>168.5</handicap>
                    </part>
                </leg>
                <leg>
                    <legNo>2</legNo>
                    <legSort>--</legSort>
                    <legType>W</legType>
                    <part>
                        <outcome>390079631</outcome>
                    </part>
                </leg>
                <leg>
                    <legNo>3</legNo>
                    <legSort>--</legSort>
                    <legType>W</legType>
                    <part>
                        <outcome>390079357</outcome>
                    </part>
                </leg>
            </bet>
        </reqBetBuild>
    </request>
</oxip>
]]