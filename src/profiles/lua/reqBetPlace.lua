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
        <token>zMocQuYjdHwGvzy3c9AcHU7jgxJoO2czHr0K/RbAsC9Qsu3NH7Htfl4aYmev1q6+RFIV0St4lxLeGNjYEOvEk/uaE3PoPcmowLM/R3RHOCxzYNpts1hO42uTdzjOLfAY+mOz1rk6AJHS</token>
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
                    <outcome>51819</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>10000</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>2</partNo>
                    <outcome>51822</outcome>
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
                    <outcome>51815</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>3500</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
        </bet> 
    </reqBetPlace>
    </request>
</oxip>
]]
wrk.headers["Content-Type"] = "application/xml"