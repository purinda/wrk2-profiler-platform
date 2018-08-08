-- HTTP method, body, and adding a header

token    = ""
xml_body =[[
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE oxip SYSTEM "oxip.dtd">
<oxip version="6.0">
    <request>
        <reqClientAuth returnToken="N">
            <user>oxiapi</user>
            <password>oxiapi</password>
        </reqClientAuth>
        <reqBetPlace pendingBetCount="Y" returnBalance="Y">
            <token>]] .. token .. [[</token>
            <errorDetail>ALL</errorDetail>
            <channel>M</channel>
            <fullDetails>Y</fullDetails>
            <clientUserAgent>11</clientUserAgent>
            <bet>
                <betNo>1</betNo>
                <stakePerLine>2</stakePerLine>
                <betType>SGL</betType>
                <legType>W</legType>
                <leg>
                    <legNo>1</legNo>
                    <legSort>--</legSort>
                    <legType>W</legType>
                    <part>
                        <partNo>1</partNo>
                        <outcome>51819</outcome>
                        <priceType>L</priceType>
                        <priceNum>300</priceNum>
                        <priceDen>1000</priceDen>
                    </part>
                </leg>
            </bet>
        </reqBetPlace>
    </request>
</oxip>
]]

base = loadfile("base.lua")
base()
wrk.body = xml_body