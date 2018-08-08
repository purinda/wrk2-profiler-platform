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
        <token>9eIMbd1ABGUZgkpI5lCV8wURr83MCidSJ5rbvfGgkj/ZnnU3a4Qczv5T4IaaiVgiblAtr26YkZbzpFYnsBOAHCWLn5c3vVlppQpvb08c5YWUjtqWYHbN9p/hdkLunFlM+plpwnOw6s4t</token>
        <errorDetail>ALL</errorDetail>
        <channel>M</channel>
        <fullDetails>Y</fullDetails>
        <clientUserAgent>11</clientUserAgent>
        <bet>
            <betNo>1</betNo>
            <stakePerLine>1</stakePerLine>
            <betType>TBL</betType>
            <leg>
                <legNo>1</legNo>
                <legSort>IM</legSort>
                <legType>W</legType>
                <part>
                    <partNo>1</partNo>
                    <outcome>51813</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>10000</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>2</partNo>
                    <outcome>51815</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>200</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>3</partNo>
                    <outcome>51818</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>200</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
            <leg>
                <legNo>2</legNo>
                <legSort>IM</legSort>
                <legType>W</legType>
                <part>
                    <partNo>1</partNo>
                    <outcome>51821</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>10000</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>2</partNo>
                    <outcome>51826</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>200</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
            <leg>
                <legNo>3</legNo>
                <legSort>IM</legSort>
                <legType>W</legType>
                <part>
                    <partNo>1</partNo>
                    <outcome>51829</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>10000</priceNum>
                    <priceDen>1000</priceDen>
                </part>
                <part>
                    <partNo>2</partNo>
                    <outcome>51832</outcome>
                    <partSort>--</partSort>
                    <priceType>L</priceType>
                    <priceNum>200</priceNum>
                    <priceDen>1000</priceDen>
                </part>
            </leg>
        </bet> 
    </reqBetPlace>
    </request>
</oxip>
]]
wrk.headers["Content-Type"] = "application/xml"