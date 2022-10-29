# TODO:   Testing zen4R
# 
# Author: Miguel Alvarez
################################################################################

library(keyring)
library(zen4R)

# Credentials
kr_name <- "miguel_keyring"
kr_service <- "zenodo"
kr_username <- "miguel"

# Connect to Zenodo
zenodo <- ZenodoManager$new(token = backend_file$new()$get(
        service = kr_service,
        user = kr_username,
        keyring = kr_name),
    logger = "INFO")

# Own records
my_zenodo_records <- zenodo$getDepositions()
my_zenodo_records

# New record
myrec <- ZenodoRecord$new()
myrec$setTitle("The World Flora Online v1.7")
myrec$setDescription(
    paste("<p>Checklist of plant species, including taxonomy, formatted as",
        "a taxlist object.</p>",
        "",
        "<p>This is a subset of the original data adapted to keep taxonomic",
        "consistency and fullfill conditions required by the R package.</p>"))
myrec$setUploadType("dataset")
myrec$addCreator(firstname = "Miguel", lastname = "Alvarez",
    affiliation = "Independent", orcid = "0000-0003-1500-1834")
myrec$setLicense("mit")
myrec$setAccessRight("open")

myrec <- zenodo$depositRecord(myrec)


