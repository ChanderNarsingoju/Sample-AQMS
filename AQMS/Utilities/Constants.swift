//
//  Constants.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import Foundation

//URLs
let ENCODE_SECRET_KEY = "9EbGeKgNjRnT"
let BASE_URL = "https://aqmsqa.scienstechnologies.com/qa-api"

let BASE_LOGIN_URL: String = "\(BASE_URL)/api/auth/local"
let UN_REGISTERED_HATCHERY_URL_PATH: String = "/api/hatcheries?_start=0&_limit=100&_sort=id:DESC&approvalStatus=ApprovalPending&approvalStatus=Rejected&userProfile_null=true"
let BOOKINGS_URL: String = BASE_URL + "/api/bookings?_sort=cr eated_at:DESC"
let UPLOAD_URL: String = BASE_URL+"/upload"
let PDF_URL: String = BASE_URL
let PDF_URL_DOWNLOAD: String = BASE_URL+"/local/download-file"
let ATTACHMENT_URL: String = BASE_URL

//Storyboards
let MAIN_STORYOARD: String = "Main"

//Identifiers
let HOME_PAGE_IDENTIFIER = "HomeVCIdentifier"
let LOGIN_PAGE_IDENTIFIER = "LoginVCIdentifier"
let SIGNUP_PAGE_IDENTIFIER = "SignUpVCIdentifier"
let MENU_IDENTIFIER = "MenuVCIdentifier"

//Cell Identifiers
let HOME_COLLECTION_VIEW_CELL_IDENTIFIER = "HomeCollectionViewCellIdentifier"
let MENU_COLLECTION_VIEW_CELL_IDENTIFIER = "MenuCollectionViewCellIdentifier"

//String constants
let ENTER_USERNAME_MESSAGE = "Please Enter Email/Phone"
let ENTER_PASSWORD_MESSAGE = "Please Enter Password"
let NO_INTERNET_MESSAGE = "No internet connection"
let LOGOUT_TITLE = "Logout"
let LOGOUT_ALERT_MESSAGE = "Are you sure you want to Logout?"
let YES = "Yes"
let NO = "No"

//API header constants
let HEADER_X_AUTH_TOKEN_KEY = "Authorization"
let HEADER_X_API_VERSION = "x-api-version"
let HEADER_X_API_SIGNATURE = "x-api-signature"
let HEADER_X_API_OPERATION = "x-api-operation"
let HEADER_CONTENT_TYPE = "Content-Type"
let HEADER_CONTENT_TYPE_VAL = "application/json"

let HEADER_X_API_VERSION_VAL = "2.0.0"

let STATUS_CODE_0 = 0
let STATUS_CODE_200 = 200
let STATUS_CODE_203 = 203
let STATUS_CODE_400 = 400
let STATUS_CODE_401 = 401
let STATUS_CODE_404 = 404
let STATUS_CODE_500 = 500


//API Constants
let IDENTIFIER = "identifier"
let PASSWORD = "password"
let NOT_TOKEN = "notificationToken"
let SOURCE_REGISTRATION = "registration"
let BOOKING_STATUS_CANCEL = "Canceled"
let BOOKING_STATUS_CONFIRMED = "Confirmed"
let BOOKING_STATUS_COMPLETED = "Completed"
let BOOKING_STATUS_BLOCKED = "Blocked"
let BOOKING_STATUS_BOOKED = "Booked"
let DATE_TIME_FORMAT = "YYYY-MM-dd'T'HH:mm:ss.sss'Z'"
let BOOK_CUBICAL_BOOKING = "cubicleBookingScheduleIds"
let BOOK_BIOMASS = "bioMassPerStock"
let BOOK_REF_NUMBER = "referenceNumber"
let BOOK_SIP_ID = "supplierId"
let BOOK_TOTAL_STOCK = "totalNumberOfStock"
let BOOK_SPECIES_TYPE = "speciesType"
let SIP_ID = "sipId"
let NEW_PASSWORD = "password"
let CONFIRM_PASSWORD = "passwordConfirmation"
let TOKEN_CODE = "code"
let ATTACHMENT = "attachment"
let SIP_NUMBER = "SIPnumber"
let PERMIT_ISSUE_DATE = "permitIssueDate"
let PERMIT_EXPIRY_DATE = "permitExpDate"
let SUPPLIER_ID = "supplierId"
let HATCHERY_ID = "hatcheryId"
let PERMITED_SAMPLE_LIMIT = "permitedSampleLimit"
let SAMPLE_IMPORTED = "sampleImported"
let STATUS = "status"
let PUBLISHED_AT = "published_at"
let CREATED_BY = "created_by"
let UPDATED_BY = "updated_by"
let AIRWAY_BILL_NUMBER = "airwayBillNumber"
let FLIGHT_NUMBER = "flightNumber"
let COUNTRY_NAME = "countryName"
let AIRLINE_NAME = "airlineName"
let DESTINATION = "destination"
let ARRIVAL_DATE = "arrivalDate"
let AIRWAY_BILL_DOC = "airwayBill"
let FLIGHT_ITI = "flightItineary"
let FLIGHT_MALE = "maleBs"
let FLIGHT_FEMALE = "femaleBs"
let FLIGHT_TOTAL_BS = "totalBs"
let FLIGHT_BOX = "box"
let FLIGHT_SPF_DOC = "spf"
let FLIGHT_DIESES_DOC = "diease"
let FLIGHT_TEST_REPORT_DOC = "testReport"
let FLIGHT_HEALTH_DOC = "health"
let FLIGHT_COMM_INVOICE = "commercialInvoice"
let FLIGHT_PACKING_DOC = "packingList"
let FLIGHT = "Flight"
let DISEASE = "DIEASE"
let UPLOAD_HEALTH = "HEALTHHH"
let AIRWAY_BILL = "Bill"
let INVOICE = "Invoice"
let REGISTRATION_NAME = "name"
let REGISTRATION_ADDRESS = "address"
let REGISTRATION_PHONE = "phoneNumber"
let REGISTRATION_BOOKING_PER_MONTH = "noOfBookingPerMonth"
let REGISTRATION_EMAIL = "email"
let REGISTRATION_PASSWORD = "password"
let REGISTRATION_PROFILE_PICTURE = "picture"
let REGISTRATION_BANK_ACC_NAME = "accountName"
let REGISTRATION_BANK_ACC_NUMBER = "accountNumber"
let REGISTRATION_BANK_ACC_TYPE = "accountType"
let REGISTRATION_BANK_NAME = "bankName"
let REGISTRATION_BANK_BRANCH_NAME = "branchName"
let REGISTRATION_BANK_IFSC = "IFSC"
let REGISTRATION_ATTACHMENT = "attachment"
let REGISTRATION_SIP_NUMBER = "SIPnumber"
let REGISTRATION_PERMITTED_SAMPLE_LIMIT = "permitedSampleLimit"
let REGISTRATION_PERMIT_EXP_DATE = "permitExpDate"
let REGISTRATION_PERMIT_ISSUE_DATE = "permitIssueDate"
let REGISTRATION_SUPPLIER_ID = "supplierId"
let REGISTRATION_LICENCE = "document"
let REGISTRATION_OTP = "OTP"
let REGISTRATION_ACCOUNT_DETAIL_PROOF = "bankAccountDetailProof"
let REGISTRATION_AUTH_PERSON_ONE = "authPerson1"
let REGISTRATION_AUTH_PERSON_TWO = "authPerson2"
