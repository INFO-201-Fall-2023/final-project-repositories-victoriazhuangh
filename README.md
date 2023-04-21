**Pitch**

Gentrification occurs when affluent people and families move into neighborhoods that have historically been home to Black, indigenous, and other people of color, leading to the displacement of the original residents (Fogel, [link](https://urban.uw.edu/news/gentrification-and-changing-foodscapes-in-seattle/#:~:text=In%20Seattle%2C%2050%25%20of%20eligible,47%25%20between%202000%20and%202013)). In the past few decades, gentrification has become an increasingly important issue within major U.S. cities. Developers and corporations often claim that gentrification increases the quality of life within target neighborhoods; however, in reality, it can also lead to a loss of culture, history, and feelings of connection between community members. And, not only does gentrification impact culture, it threatens the food and housing security of existing residents in gentrifying areas who may not be able to afford increasing rent and food prices (Fogel).  

When discussing gentrification, it is important to recognize the ongoing displacement in Seattle, the third most quickly gentrifying city in the United States after Washington, D.C. and Portland (Fogel). An example of a gentrifying neighborhood in Seattle is the Chinatown-International District (CID), which has a history dating back to the beginning of the twentieth century (UW, [link](http://courses.washington.edu/udp508/info/chinatown.html)), has been identified as one of the neighborhoods facing the most risk of displacement (Kuo, [link](https://www.theurbanist.org/2022/03/22/cid-growing-pains-and-opportunities/)). With its rich history and cultural presence in Seattle, displacement of the CID would result in the loss of culture and community along with homes and local businesses. Additionally, Wallingford (a North Seattle neighborhood that has close proximity to Lake Union and the University District) has faced gentrification in recent history ‒ after the Boeing slump in the late twentieth century, the prices of Wallingford homes rapidly increased (Dorpat, [link](https://www.historylink.org/file/3461)). The rising home and living prices would have likely led to the displacement of preexisting residents in the area. 

As we can see, both Wallingford and the CID have been impacted by gentrification. There is, however, a key difference between the two neighborhoods: Wallingford is predominantly white (Niche, [link](https://www.niche.com/places-to-live/n/wallingford-seattle-wa/residents/)), while the CID is not (Niche, [link](https://www.niche.com/places-to-live/n/international-district-seattle-wa/residents/)). This difference suggests that the gentrification faced in both neighborhoods is not equal; therefore, in our project, we will explore and compare gentrification in the Chinatown-International District and Wallingford for the years 2013-2020 More specifically, we ask: What is the relationship between built units and population change in the International District? In Wallingford? How do existing population demographics influence the rate at which new developments appear, and how do new developments affect demographics? To answer our questions, we utilize two data sets from the City of Seattle GIS Program and the U.S. Census ‒ the former concerns built units since 2010, and the latter provides racial demographic data at the block-group level. In our analysis, we will compare the number of built units to the racial demographics of its corresponding neighborhood for each year between 2013 and 2020. We hope that our research reveals new information about the relationship between racial demographics and gentrification ‒ this nuanced information will be important for local governments’ decisions about building development, and community-based movements towards de-gentrification.

**Data**

In this project, we will utilize the following two datasets:

_Built Units Since 2010 from the City of Seattle GIS Program_
- This data was collected by a member of the City of Seattle GIS Program. It was first published on January 5, 2020, and was most recently updated on April 11, 2023. The website does not contain information about how the data was collected.
- We accessed and downloaded this data at the following URL: https://data-seattlecitygis.opendata.arcgis.com/datasets/SeattleCityGIS::built-units-since-2010/explore?location=47.614500%2C-122.330455%2C12.00&showTable=true. 
- This dataset has 18505 observations and 57 features. 

_Table B02001 from the U.S. Census_
- This data was collected by the U.S. Census Bureau, which uses data from censuses, surveys, and administrative data (data from U.S. government agencies and occasionally commercial entities). This dataset contains information (count data) about the racial makeup of King County at the block group level. 
- We accessed and downloaded this data at the following URL: https://data.census.gov/table?q=table+b02001&g=050XX00US53033$1500000&tid=ACSDT5Y2020.B02001. 
- On the Census website, we filtered the dataset to only display information for block groups in King County for all the years between 2013 and 2020. For each year, there are 42 features; however, the number of observations varies ‒ from 2013-2019, there are 1422 observations, and for 2020, there are 1545 observations.

**Background Research**

In our research, we found the articles and posts listed below. Here, we discuss how our project builds upon or extends prior ideas and discoveries.

_"Watching Chinatown's Gentrifying/Generational Change" by Shaun Kuo_
- URL: https://www.theurbanist.org/2022/06/14/kuo-%E9%83%AD-watching-chinatowns-gentrifying-generational-change/ 
- Kuo examines census data for age, income, and race in Chinatown for 2010 and 2020. Through his data analysis, he reveals that the dominant age group in Chinatown has shifted from elderly to young folks, the median income in the neighborhood has doubled, and the East Asian population has increased.
- In his discussion of gentrification in Chinatown, Kuo does not directly utilize data about new building developments, which we will do. 
- Our project will also contrast change in Chinatown to Wallingford, a predominantly white neighborhood, which may reveal new insights about gentrification in neighborhoods with different racial makeups.

_"Race, Immigration, and Gentrification in Seattle, 1970-2013" by David Luberoff_
- URL: https://www.jchs.harvard.edu/blog/race-immigration-and-gentrification-in-seattle-1970-2013
- Luberoff discusses findings from Jackelyn Hwang’s article “Gentrification without Segregation? Race, Immigration, and Renewal in a Diversifying City.” Hwang finds that in the 1990s and 2000s, gentrification was more likely to occur in areas with a larger Black population than in areas with a smaller Asian population. 
- Like Hwang, we will investigate gentrification in two areas with very different racial makeups: Wallingford (a predominantly white area) and the CID (a predominantly Asian area). 
- Our project may build on Hwang’s findings, as we will explore gentrification from 2013 to 2020, which is immediately after her period of study. 

_"International District Development Wave Comes with Growing Pains and Opportunities" by Shaun Kuo_
- URL: https://www.theurbanist.org/2022/03/22/cid-growing-pains-and-opportunities/ 
- In this article, Kuo examines the development and permit activity in the CID from 2019-2022. He uses maps to visualize the locations of expected high- and mid-rise developments in Japantown, Chinatown, and Little Saigon. 
- Like Kuo, we will examine development and permit data; our project departs from his in that we will compare development and permit data from Wallingford and the CID.
- Kuo visually differentiates expected developments that will be market-rate from those that are affordable or income-restriction. We will not be doing this, as we do not have the necessary data, but it would be a fascinating topic for a future project. 

_"In high-rise cities like Seattle, can Chinatowns survive?" by Glenn Nelson_
- URL: https://crosscut.com/2019/05/high-rise-cities-seattle-can-chinatowns-survive 
- In this article, Nelson describes the impact of gentrification on Chinatown-ID in Seattle and the looming presence of displacement. Some of the context describes similar situations all around Chinatowns in the country. Nelson goes into detail about the new developments in place of Chinatown and how this will drive out the community and cultural significance that makes Chinatown, Chinatown. 
- Like Nelson, we plan to explore the recent uptake of gentrification in Seattle’s CID and its negative impact on the community. Nelson also discusses the changing demographic of Chinatown which is another aspect that we will be focusing on. 
- In contrast to Nelson, we will not only focus on Chinatown but also Wallingford. We plan to compare and contrast both districts based on their rate of gentrification with a focus on their demographics. 

_"Seattle Neighborhoods: Wallingford - Thumbnail History" by Paul Dorpat_
- URL: https://www.historylink.org/file/3461
- We will use the information provided in this article to cover the background of Wallingford and how its history has affected the pattern of gentrification in this district throughout the years.
- However, instead of focusing mainly on the history, like this article does, our main focus for Wallingford will be on the pattern of gentrification. Specifically, we hope to look for gentrification patterns in its more recent years which is what this article does not touch on. 

