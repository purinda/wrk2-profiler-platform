-- HTTP method, body, and adding a header
token    = "/+MhZqYnQXOVddgKNlb/0Q1L1Dst2ytk7zbsXstRSKhFXYr5EgDa0na48DByGRl+AlC3z/B+yy1cDmrMvWme/wu6QsfkSRwvs89u/lE9a6wEakpHT5kFK8mFk1SpnK8C/hH1thO5a2Zy"

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/xml"
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
                <stakePerLine>1</stakePerLine>
                <betType>SGL</betType>
                <legType>W</legType>
                <leg>
                    <legNo>1</legNo>
                    <legSort>--</legSort>
                    <legType>W</legType>
                    <part>
                        <partNo>1</partNo>
                        <outcome>51813</outcome>
                        <priceType>L</priceType>
                        <priceNum>1200</priceNum>
                        <priceDen>1000</priceDen>
                    </part>
                </leg>
            </bet>
        </reqBetPlace>
    </request>
</oxip>
]]

wrk.body = xml_body