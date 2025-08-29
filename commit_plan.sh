#!/bin/bash
# Script to automate backdated git commits for dotnet-microservices repo
# Usage: bash commit_plan.sh

set -e

# Plan: Each entry is: DATE|FILES|MESSAGE
# Format: YYYY-MM-DD|file1[,file2]|commit message

commit_plan="""
2025-07-01|README.md|Initial project setup and documentation
2025-07-03|docker-compose.yml|Setup Docker Compose for local development
2025-07-03|Database/SqlCmdScript.sql|Add database schema initialization script
2025-07-05|.gitignore|Add gitignore for .NET and IDE artifacts
2025-07-06|dotnetgigs.sln|Add solution file
2025-07-07|Foundation/Events/IntegrationEvent.cs|Add integration event base class
2025-07-09|Foundation/Events/ApplicantAppliedEvent.cs|Implement ApplicantAppliedEvent
2025-07-10|Foundation/Events/Events.csproj|Add Events project file
2025-07-12|Foundation/Http/IHttpClient.cs|Add HTTP client abstraction interface
2025-07-12|Foundation/Http/StandardHttpClient.cs|Implement StandardHttpClient
2025-07-14|Foundation/Http/Http.csproj|Add Http project file
2025-07-15|Services/Applicants.Api/Program.cs|Initialize Applicants.Api entry point
2025-07-16|Services/Applicants.Api/applicants.api.csproj|Add Applicants.Api project file
2025-07-18|Services/Applicants.Api/Controllers/ApplicantsController.cs|Add ApplicantsController with CRUD endpoints
2025-07-21|Services/Applicants.Api/Models/Applicant.cs|Add Applicant model
2025-07-21|Services/Applicants.Api/Services/ApplicantRepository.cs|Implement ApplicantRepository
2025-07-23|Services/Applicants.Api/Models/ApplicantSubmission.cs|Add ApplicantSubmission model
2025-07-25|Services/Identity.Api/Program.cs|Initialize Identity.Api service
2025-07-26|Services/Identity.Api/Identity.Api.csproj|Add Identity.Api project file
2025-07-28|Services/Identity.Api/Models/User.cs|Add User model for identity service
2025-07-31|Services/Identity.Api/Controllers/UsersController.cs|Implement UsersController endpoints
2025-08-02|Services/Applicants.Api/Startup.cs|Configure Applicants.Api startup and DI
2025-08-04|Services/Applicants.Api/appsettings.json|Add Applicants.Api app settings
2025-08-05|Services/Applicants.Api/appsettings.Development.json|Add development overrides for Applicants.Api
2025-08-07|Services/Applicants.Api/Messaging/Consumers/ApplicantAppliedEventConsumer.cs|Add event consumer for applicant events
2025-08-11|Services/Applicants.Api/Dockerfile.debug|Add debug Dockerfile for Applicants.Api
2025-08-13|Services/Identity.Api/Services/IIdentityRepository.cs|Add identity repository interface
2025-08-13|Services/Identity.Api/Services/IdentityRepository.cs|Implement IdentityRepository
2025-08-15|Services/Identity.Api/Startup.cs|Configure Identity.Api startup and DI
2025-08-18|Services/Identity.Api/appsettings.json|Add Identity.Api app settings
2025-08-19|Services/Identity.Api/appsettings.Development.json|Add development overrides for Identity.Api
2025-08-21|Services/Identity.Api/Messaging/Consumers/ApplicantAppliedEventConsumer.cs|Add event consumer in Identity.Api
2025-08-22|Services/Identity.Api/Dockerfile.debug|Add debug Dockerfile for Identity.Api
2025-08-25|Database/Dockerfile|Add database Dockerfile
2025-08-25|Database/entrypoint.sh|Add database Docker entrypoint script
2025-08-25|Database/SqlCmdStartup.sh|Add SQL startup script for container
2025-08-29|commit_plan.sh|Add automated backdated commit script
2025-09-03|Services/Jobs.Api/jobs.api.csproj|Initialize Jobs.Api project
2025-09-03|Services/Jobs.Api/Program.cs|Add Jobs.Api program entry point
2025-09-08|Services/Jobs.Api/Models/Job.cs|Add Job model
2025-09-10|Services/Jobs.Api/Models/JobApplicant.cs|Add JobApplicant model
2025-09-12|Services/Jobs.Api/Services/IJobRepository.cs|Add job repository interface
2025-09-15|Services/Jobs.Api/Services/JobRepository.cs|Implement JobRepository
2025-09-17|Services/Jobs.Api/Controllers/JobsController.cs|Add JobsController with CRUD endpoints
2025-09-22|Services/Jobs.Api/Startup.cs|Configure Jobs.Api startup and DI
2025-09-24|Services/Jobs.Api/appsettings.json|Add Jobs.Api app settings
2025-09-24|Services/Jobs.Api/appsettings.Development.json|Add development overrides for Jobs.Api
2025-09-29|Services/Jobs.Api/Dockerfile.debug|Add debug Dockerfile for Jobs.Api
2025-10-02|Web/Web.csproj|Initialize Web project
2025-10-02|Web/Program.cs|Add Web application entry point
2025-10-06|Web/Startup.cs|Configure Web application startup
2025-10-08|Web/appsettings.json|Add Web app settings
2025-10-09|Web/appsettings.Development.json|Add development overrides for Web
2025-10-13|Web/Config/ApiConfig.cs|Add API base URL configuration
2025-10-15|Web/Services/IIdentityService.cs|Add identity service interface
2025-10-15|Web/Services/IdentityService.cs|Implement IdentityService
2025-10-20|Web/Services/IJobService.cs|Add job service interface
2025-10-20|Web/Services/JobService.cs|Implement JobService
2025-10-23|Web/Models/ErrorViewModel.cs|Add error view model
2025-10-27|Web/Controllers/HomeController.cs|Add HomeController
2025-10-29|Web/Controllers/JobsController.cs|Add JobsController for web frontend
2025-11-03|Web/ViewModels/Job.cs|Add Job view model
2025-11-03|Web/ViewModels/JobApplicant.cs|Add JobApplicant view model
2025-11-06|Web/ViewModels/User.cs|Add User view model
2025-11-10|Web/ViewModels/HomeViewModels/IndexViewModel.cs|Add home index view model
2025-11-12|Web/ViewModels/JobsViewModels/ApplyViewModel.cs|Add job apply view model
2025-11-12|Web/ViewModels/JobsViewModels/ApplySuccessViewModel.cs|Add apply success view model
2025-11-14|Web/ViewModels/JobsViewModels/JobApplicationViewModel.cs|Add job application view model
2025-11-18|Web/Views/_ViewImports.cshtml|Add Razor view imports
2025-11-18|Web/Views/_ViewStart.cshtml|Add Razor view start configuration
2025-11-21|Web/Views/Shared/_Layout.cshtml|Add shared layout template
2025-11-24|Web/Views/Shared/Error.cshtml|Add error view
2025-11-24|Web/Views/Shared/_ValidationScriptsPartial.cshtml|Add validation scripts partial
2025-11-27|Web/Views/Home/Index.cshtml|Add home index view
2025-11-28|Web/Views/Home/About.cshtml|Add about page view
2025-11-28|Web/Views/Home/Contact.cshtml|Add contact page view
2025-12-01|Web/Views/Jobs/Apply.cshtml|Add job application view
2025-12-01|Web/Views/Jobs/ApplySuccess.cshtml|Add job application success view
2025-12-04|Web/Dockerfile.debug|Add debug Dockerfile for Web
2025-12-08|Web/.bowerrc|Add bower configuration
2025-12-08|Web/bower.json|Add bower frontend dependencies
2025-12-11|Web/bundleconfig.json|Add CSS/JS bundle configuration
2025-12-15|Web/wwwroot/favicon.ico|Add site favicon
2025-12-17|Web/wwwroot/css/site.css|Add site stylesheet
2025-12-17|Web/wwwroot/css/site.min.css|Add minified site stylesheet
2025-12-22|Web/wwwroot/js/site.js|Add site JavaScript
2025-12-22|Web/wwwroot/js/site.min.js|Add minified site JavaScript
2025-12-29|Web/wwwroot/images/banner1.svg|Add homepage banner images
2025-12-29|Web/wwwroot/images/banner2.svg|Add second banner image
2026-01-05|Web/wwwroot/images/banner3.svg|Add third banner image
2026-01-05|Web/wwwroot/images/banner4.svg|Add fourth banner image
2026-01-09|Web/wwwroot/lib/bootstrap/.bower.json|Add Bootstrap bower metadata
2026-01-12|Web/wwwroot/lib/bootstrap/LICENSE|Add Bootstrap license file
2026-01-14|Web/wwwroot/lib/bootstrap/dist/css/bootstrap.css|Add Bootstrap CSS
2026-01-14|Web/wwwroot/lib/bootstrap/dist/css/bootstrap.css.map|Add Bootstrap CSS source map
2026-01-17|Web/wwwroot/lib/bootstrap/dist/css/bootstrap.min.css|Add Bootstrap minified CSS
2026-01-17|Web/wwwroot/lib/bootstrap/dist/css/bootstrap.min.css.map|Add Bootstrap minified CSS source map
2026-01-21|Web/wwwroot/lib/bootstrap/dist/css/bootstrap-theme.css|Add Bootstrap theme CSS
2026-01-21|Web/wwwroot/lib/bootstrap/dist/css/bootstrap-theme.css.map|Add Bootstrap theme CSS source map
2026-01-24|Web/wwwroot/lib/bootstrap/dist/css/bootstrap-theme.min.css|Add Bootstrap theme minified CSS
2026-01-24|Web/wwwroot/lib/bootstrap/dist/css/bootstrap-theme.min.css.map|Add Bootstrap theme minified CSS source map
2026-02-02|Web/wwwroot/lib/bootstrap/dist/fonts/glyphicons-halflings-regular.eot|Add Bootstrap Glyphicon EOT font
2026-02-04|Web/wwwroot/lib/bootstrap/dist/fonts/glyphicons-halflings-regular.svg|Add Bootstrap Glyphicon SVG font
2026-02-04|Web/wwwroot/lib/bootstrap/dist/fonts/glyphicons-halflings-regular.ttf|Add Bootstrap Glyphicon TTF font
2026-02-07|Web/wwwroot/lib/bootstrap/dist/fonts/glyphicons-halflings-regular.woff|Add Bootstrap Glyphicon WOFF font
2026-02-07|Web/wwwroot/lib/bootstrap/dist/fonts/glyphicons-halflings-regular.woff2|Add Bootstrap Glyphicon WOFF2 font
2026-02-11|Web/wwwroot/lib/bootstrap/dist/js/bootstrap.js|Add Bootstrap JavaScript
2026-02-11|Web/wwwroot/lib/bootstrap/dist/js/bootstrap.min.js|Add Bootstrap minified JavaScript
2026-02-14|Web/wwwroot/lib/bootstrap/dist/js/npm.js|Add Bootstrap npm entry script
2026-02-17|Web/wwwroot/lib/jquery/.bower.json|Add jQuery bower metadata
2026-02-17|Web/wwwroot/lib/jquery/LICENSE.txt|Add jQuery license file
2026-02-20|Web/wwwroot/lib/jquery/dist/jquery.js|Add jQuery library
2026-02-20|Web/wwwroot/lib/jquery/dist/jquery.min.js|Add jQuery minified library
2026-02-24|Web/wwwroot/lib/jquery/dist/jquery.min.js.map|Add jQuery source map
2026-02-26|Web/wwwroot/lib/jquery-validation/.bower.json|Add jQuery Validation bower metadata
2026-02-26|Web/wwwroot/lib/jquery-validation/LICENSE.md|Add jQuery Validation license
2026-03-03|Web/wwwroot/lib/jquery-validation/dist/jquery.validate.js|Add jQuery Validation library
2026-03-03|Web/wwwroot/lib/jquery-validation/dist/jquery.validate.min.js|Add jQuery Validation minified library
2026-03-06|Web/wwwroot/lib/jquery-validation/dist/additional-methods.js|Add jQuery Validation additional methods
2026-03-06|Web/wwwroot/lib/jquery-validation/dist/additional-methods.min.js|Add jQuery Validation additional methods minified
2026-03-10|Web/wwwroot/lib/jquery-validation-unobtrusive/.bower.json|Add jQuery unobtrusive validation bower metadata
2026-03-12|Web/wwwroot/lib/jquery-validation-unobtrusive/jquery.validate.unobtrusive.js|Add jQuery unobtrusive validation library
2026-03-12|Web/wwwroot/lib/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js|Add jQuery unobtrusive validation minified
2026-03-17|.vscode/launch.json|Add VS Code launch configuration
2026-03-17|.vscode/tasks.json|Add VS Code tasks configuration
2026-03-20|.vscode/tasks.json.old|Add previous VS Code tasks backup
"""

# Convert plan to array
IFS=$'\n' read -rd '' -a commits <<<"$commit_plan" || true

for entry in "${commits[@]}"; do
  [[ -z "$entry" ]] && continue
  IFS='|' read -r date files message <<< "$entry"
  # Randomize commit time within the day
  hour=$((RANDOM % 24))
  min=$((RANDOM % 60))
  sec=$((RANDOM % 60))
  commit_datetime="$date"T$(printf "%02d:%02d:%02d" $hour $min $sec)
  # Stage files
  IFS=',' read -ra filearr <<< "$files"
  for f in "${filearr[@]}"; do
    git add "$f"
  done
  # Commit with backdated timestamp
  GIT_AUTHOR_DATE="$commit_datetime" GIT_COMMITTER_DATE="$commit_datetime" git commit -m "$message"
done

echo "All planned commits completed."
