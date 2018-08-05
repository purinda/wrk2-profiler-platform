-- HTTP method, body, and adding a header

wrk.method = "POST"
wrk.body   =[[
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE oxip SYSTEM "oxip.dtd">
<oxip version="6.0">
    <request>
        <reqClientAuth returnToken="N">
            <user>oxiapi</user>
            <password>oxiapi</password>
    </reqClientAuth>
    <reqBetPlace pendingBetCount="Y" returnBalance="Y">
        <token>{{token}}</token>
        <errorDetail>ALL</errorDetail>
        <channel>M</channel>
        <fullDetails>Y</fullDetails>
        <clientUserAgent>11</clientUserAgent>
        <bet>
            <betNo>1</betNo>
            <stakePerLine>40</stakePerLine>
            <betType>DBL</betType>
            <leg>
                <legNo>1</legNo>
                <legSort>IM</legSort>
                <legType>W</legType>
                <part>
                    <partNo>1</partNo>
                    <outcome>400923087</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>10000</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>2</partNo>
                    <outcome>400923084</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>200</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
            <leg>
                <legNo>2</legNo>
                <legSort>--</legSort>
                <legType>W</legType>
                <part>
                    <partNo>1</partNo>
                    <outcome>400924126</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>100</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
        </bet> 
    </reqBetPlace>
    </request>
</oxip>
]]
wrk.headers["Content-Type"] = "application/xml"