# frozen_string_literal: true

class Views::Pages::Privacy < Views::Base
  def view_template
    Prose <<~MD
    # #{title 'Privacy policy'}
    This is the name.pn privacy policy. We want to be clear about how we will use the information you give us and keep it safe.

    It tells you how we look after your personal data, like your name or photo, when you visit our website wherever you visit it from. It tells you about your privacy rights and how the law protects you.

    This privacy policy is provided in a layered format so you can click through to the specific areas set out below.

    name.pn puts you in control - your name, your rules. The short-URL we create and identity data is set and managed by you, and you choose what is made public by using our service.

    name.pn will not ask you for personal information about yourself except where it will be published on your own name.pn page. Apart from a few fields needed to ensure a uniform experience, most data requested is optional and you only need to provide it if you want it to be on your page.

    * [1. Important information and who we are](#1-important-information-and-who-we-are)
    * [2. The data we collect about you](#2-the-data-we-collect-about-you)
    * [3. How is your personal data collected?](#3-how-is-your-personal-data-collected)
    * [4. How we use your personal data](#4-how-we-use-your-personal-data)
    * [5. Disclosures of your personal data](#5-disclosures-of-your-personal-data)
    * [6. International transfers](#6-international-transfers)
    * [7. Data security](#7-data-security)
    * [8. Data retention](#8-data-retention)
    * [9. Your legal rights](#9-your-legal-rights)

    ## 1. Important information and who we are
    
    ### Purpose of this privacy policy
    
    This privacy policy gives you information on how name.pn collects and uses your personal data when you visit this website, including any data you may provide through this website when you use our service.

    We only use the data you provide us, and don’t collect data about you from anywhere else.

    This website is not intended for children and we do not knowingly collect data relating to children.

    It is important that you read this privacy policy together with any other information we may provide on specific occasions when we are collecting or processing personal data about you. For example, if we were to offer new services or email contact options.

    This privacy policy supplements other notices and privacy policies and is not intended to override them.

    Third parties that may be involved in processing your data are:

    * [Heroku Postgres](https://www.heroku.com/postgres): Your profile data is stored and backed up here.
    * [Amazon Web Services](https://aws.amazon.com/): If you upload images or audio, they are stored here.
    * [Buttondown](https://buttondown.email/): We use your email address and name preferences to send you occasional emails, if you have opted in.
    * [Google Analytics](https://analytics.google.com/): We use this to understand more about who is visiting our site.
    * [Datadog](https://www.datadoghq.com/): We send technical data about the functioning of the application to Datadog in order to predict and diagnose issues with the site.
    
    ### Controller
    
    name.pn is the controller and responsible for your personal data. We are referred to as name.pn, "we", "us" or "our" in this privacy policy.

    If you have any questions about this privacy policy, including any requests to exercise [your legal rights](#9-your-legal-rights), please contact us using the details set out below.

    ### Contact details
    
    If you have any questions about this privacy policy, you can contact us at:

    * Full name of legal entity: Fish Percolator Limited
    * Email address: privacy@fishpercolator.co.uk
    * Postal address: International House, 14 King Street, Leeds LS1 2HL, United Kingdom
    
    You have the right to make a complaint at any time to the [Information Commissioner's Office (ICO)](https://www.ico.org.uk/), the UK regulator for data protection issues. Our ICO registration is ZB138365.

    We would appreciate the chance to deal with your concerns before you approach the ICO.

    ### Changes to the privacy policy and your duty to inform us of changes
    
    We keep our privacy policy under regular review. This version is dated 4 June 2025.

    It is important that the personal data we hold about you is accurate and current. Our service lets you ensure the personal data we hold can be updated by you when needed.

    ### Third-party links
    
    This website may include links to third-party websites, plug-ins and applications. Clicking on those links or enabling those connections may allow third parties to collect or share data about you. We do not control these third-party websites and are not responsible for their privacy statements. When you leave our website, we encourage you to read the privacy policy of every website you visit.

    ## 2. The data we collect about you
    
    Personal data, or personal information, means any information about an individual from which that person can be identified - like your name or photo. It does not include data where the identity has been removed (anonymous data).

    We may collect, use, store and transfer different kinds of personal data about you which we have grouped together as follows:

    * Identity Data includes various forms of your personal name, your photo/likeness and your social media profiles.
    * Contact Data includes email address.
    * Technical Data includes internet protocol (IP) address, your login data, browser type and version, and the times of your visits.
    * Usage Data includes information about how you use our website.
    * Marketing and Communications Data includes your preferences in receiving marketing from us and your communication preferences.
    
    We also collect, use and share Aggregated Data such as statistical or demographic data for any purpose. Aggregated Data could be derived from your personal data but is not considered personal data in law as this data will not directly or indirectly reveal your identity. For example, we may aggregate your Usage Data to calculate the percentage of users accessing a specific website feature.

    However, if we combine or connect Aggregated Data with your personal data so that it can directly or indirectly identify you, we treat the combined data as personal data which will be used in accordance with this privacy policy.

    We do not collect any Special Categories of Personal Data about you (this includes details about your race or ethnicity, religious or philosophical beliefs, sex life, sexual orientation, political opinions, trade union membership, information about your health, and genetic and biometric data). Nor do we collect any information about criminal convictions and offences.

    ## 3. How is your personal data collected?
    
    We use different methods to collect data from and about you including:

    * Personal interactions. You may give us your Identity, Contact and Financial Data by filling in forms or by sending us an email. This includes personal data you provide when you:
        * create an account on our website;
        * fill out your public profile information using our website;
        * subscribe to our service or publications;
        * request marketing to be sent to you;
        * give us feedback or contact us.
    * Automated technologies or interactions. As you interact with our website, we will automatically collect Technical Data about your equipment, browsing actions and patterns. We collect this personal data by using cookies, server logs and other similar technologies. Technical Data from the following parties:
        * analytics providers such as Google based outside the UK;
        * advertising networks such as Instagram based outside the UK; and
        * search information providers such as Google based outside the UK.
    
    ## 4. How we use your personal data
    
    We will only use your personal data as the law allows us to. We make sure we have a clear legal basis. We will use your personal data in the following circumstances:

    * Where it is necessary for our legitimate interests (or those of a third party) and your interests and fundamental rights do not override those interests. We have a legitimate interest in offering this service to allow people to better communicate their name and personal pronouns on the internet.
    * Where we need to comply with a legal obligation.
    
    We do not use consent as a legal basis for processing your personal data, but we will get your consent before sending third party direct marketing communications to you via email or text message.

    You have the right to withdraw consent to marketing at any time by contacting us or by using [the opt-out form available on your account page](#{edit_user_registration_path}).

    ### Purposes for which we will use your personal data
    
    We have set out a table of all the ways we plan to use your personal data, and which of the legal bases we rely on to do so. We have also identified what our legitimate interests are where appropriate.

    We may process your personal data for more than one lawful ground depending on the specific purpose for which we are using your data.

    Please contact us if you need details about the specific legal ground we are relying on to process your personal data where more than one ground has been set out in the table below.

    | Purpose | Type of data | Lawful basis for processing |
    |---------|--------------|-----------------------------|
    | To register you as a new user	| <ol><li>Identity</li><li>Contact</li></ol> | Legitimate interest |
    
    To manage our relationship with you which will include:
    Notifying you about changes to our terms or privacy policy
    Receiving email updates
    Identity
    Contact
    Profile
    Marketing and Communications
    Legitimate interest
    To administer and protect our business and this website (including troubleshooting, data analysis, testing, system maintenance, support, reporting and hosting of data)	
    Identity
    Contact
    Technical
    Legitimate interest; Necessary to comply with a legal obligation
    To use data analytics to improve our website, products/services, marketing, customer relationships and experiences	
    Technical
    Usage
    Necessary for our legitimate interests (to define types of customers for our products and services, to keep our website updated and relevant, to develop our business and to inform our marketing strategy)
    
    ### Opting out
    
    You can ask us or third parties to stop sending you marketing messages at any time by logging into the website and unsubscribing from [your account page](#{edit_user_registration_path}) OR by following the opt-out links on any marketing message sent to you OR by contacting us at any time.

    Where you opt out of receiving these marketing messages, this will not apply to personal data provided to us as a result of a product/service purchase, warranty registration, product/service experience or other transactions.

    ### Cookies
    
    You can set your browser to refuse all or some browser cookies, or to alert you when websites set or access cookies. If you disable or refuse cookies, please note that some parts of this website may become inaccessible or not function properly.

    The cookies we use are:

    _name_pn_session
    : Used to identify your current browser session and store encrypted information related to whether you are logged in and what user you are logged in as.
    
    remember_user_token 
    : If you select 'remember me' on the login page, this cookie will be used to log you back in when you return to name.pn in a future session.
    
    _ga 
    : Used by Google Analytics to collect the analytics data described above.
    
    ### Change of purpose
    
    We will only use your personal data for the purposes for which we collected it, unless we reasonably consider that we need to use it for another reason and that reason is compatible with the original purpose.

    If you wish to get an explanation as to how the processing for the new purpose is compatible with the original purpose, please contact us.

    If we need to use your personal data for an unrelated purpose, we will notify you and we will explain the legal basis which allows us to do so.

    Please note that we may process your personal data without your knowledge or consent, in compliance with the above rules, where this is required or permitted by law.

    ## 5. Disclosures of your personal data
    
    We may share your personal data with the parties set out below for the purposes set out in the table above.

    Internal Third Parties as set out in the Glossary.
    External Third Parties as set out in the Glossary.
    Third parties to whom we may choose to sell, transfer or merge parts of our business or our assets. Alternatively, we may seek to acquire other businesses or merge with them. If a change happens to our business, then the new owners may use your personal data in the same way as set out in this privacy policy.
    We require all third parties to respect the security of your personal data and to treat it in accordance with the law. We do not allow our third-party service providers to use your personal data for their own purposes and only permit them to process your personal data for specified purposes and in accordance with our instructions.

    ## 6. International transfers
    
    Many of our external third parties are based outside the UK so their processing of your personal data will involve a transfer of data outside the UK

    Whenever we transfer your personal data out of the UK, we ensure a similar degree of protection is afforded to it by ensuring at least one of the following safeguards is implemented:

    We will only transfer your personal data to countries that have been deemed to provide an adequate level of protection for personal data.
    Where we use certain service providers, we may use specific contracts approved for use in the UK which give personal data the same protection it has in the UK.
    Please contact us if you want further information on the specific mechanism used by us when transferring your personal data out of the UK.

    ## 7. Data security
    
    We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorised way, altered by people other than you or disclosed.

    In addition, we limit access to your personal data to those employees, agents, contractors and other third parties who have a business need to know. They will only process your personal data on our instructions and they are subject to a duty of confidentiality. The duty of confidentiality does not extend to information you have made public, but does apply to private information you provide to us such as your email address and IP address.

    We have put in place procedures to deal with any suspected personal data breach and will notify you and any applicable regulator of a breach where we are legally required to do so.

    ## 8. Data retention
    
    How long will you use my personal data for?
    We will only keep your personal data for as long as reasonably necessary to fulfil the purposes we collected it for. You can choose to keep using name.pn as long as you like, and while using it your personal data will be retained. If you want to stop using name.pn, your data will be deleted from the main application immediately and from backups in 4 weeks.

    We may keep your personal data for a longer period in the event of a complaint or if we reasonably believe there is a prospect of litigation in respect to our relationship with you.

    To determine the appropriate retention period for personal data, we consider the amount, nature and sensitivity of the personal data, the potential risk of harm from unauthorised use or disclosure of your personal data, the purposes for which we process your personal data and whether we can achieve those purposes through other means.

    In some circumstances you can ask us to delete your data: see your legal rights below for further information.

    In some circumstances we will anonymise your personal data (so that it can no longer be associated with you) for research or statistical purposes, in which case we may use this information indefinitely without further notice to you.

    ## 9. Your legal rights
    
    You have rights under data protection laws in relation to your personal data. Please click on the links below to find out more about these rights:

    Request access to your personal data - you can view most of your personal data by using our service. You can request a copy of any other information we hold about you.
    Request correction of your personal data - you can correct most of your personal data by using our service. You can request a correction of any other information we hold about you.
    Request erasure of your personal data - you can erase or delete most of your personal data by using our service. You can request erasure of any other information we hold about you.
    Object to processing of your personal data - you can object to our use of your personal data where this is outside the use of our service, which you are in control of.
    Request restriction of processing your personal data - you can request that we restrict the further use of your personal data.
    Request transfer of your personal data - you can use our service to receive a transfer of your personal data.
    If you wish to request any of the rights set out above, please contact privacy@fishpercolator.co.uk.

    No fee usually required
    You will not have to pay a fee to access your personal data (or to exercise any of the other rights). However, we may charge a reasonable fee if your request is clearly unfounded, repetitive or excessive. Alternatively, we could refuse to comply with your request in these circumstances.

    What we may need from you
    We may need to request specific information from you to help us confirm your identity and ensure your right to access your personal data (or to exercise any of your other rights). This is a security measure to ensure that personal data is not disclosed to any person who has no right to receive it. We may also contact you to ask you for further information in relation to your request to speed up our response.

    Time limit to respond
    We try to respond to all legitimate requests within one month. Occasionally it could take us longer than a month if your request is particularly complex or you have made a number of requests. In this case, we will notify you and keep you updated.
    MD
  end

end
