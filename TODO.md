Flutter App Development Task
Task Overview:
You are required to develop a Flutter application that allows users to manage and edit personal information through a multi-screen interface. The app will utilize local storage for data persistence and include form validation features.
App Requirements:
Home Screen:
Implement a HomeScreen with an AppBar containing a plus icon button on the top-right corner.
Display saved user data (Name, Email, Gender) on the screen along with an "Edit" button for each entry.
Tapping the plus icon should navigate to the FormScreen for entering new data.
Form Screen (FormScreen and EditFormScreen):
Create a FormScreen to allow users to enter their Name, Email, and Gender (using radio buttons for Male/Female).
Implement form validation to ensure all fields are filled before enabling the "Save" button.
Upon saving, validate the form and store the data locally using shared_preferences.
Develop an EditFormScreen to enable editing of existing entries:
Populate the form fields with the selected entry's data for editing.
Allow users to modify Name, Email, and Gender.
Implement a "Save Changes" button to update the edited data in local storage.
Implementation Steps:
HomeScreen:
Create a new Flutter project.
Scaffold a HomeScreen with an AppBar containing a plus icon button.
Retrieve and display saved user data from local storage (shared_preferences) on the screen.
Implement navigation to the FormScreen when the plus icon button is tapped.
FormScreen and EditFormScreen:
Develop a FormScreen for adding new user data:
Design form fields for Name, Email, and Gender (using radio buttons).
Use form validation to ensure all fields are filled before enabling the "Save" button.
Save validated data to local storage (shared_preferences) upon successful submission.
Implement an EditFormScreen for editing existing entries:
Populate form fields with selected entry's data for editing.
Implement data validation and update local storage with edited data upon saving.
Navigation and State Management:
Use Flutter's Navigator for screen navigation between HomeScreen, FormScreen, and EditFormScreen.
Manage app state and data using appropriate state management techniques (e.g., setState, Provider, Bloc).
Additional Considerations:
Ensure proper error handling and validation for user inputs.
Display feedback messages (success/error) upon form submission or data update.
Organize code into reusable widgets and functions for modularity and readability.
Thoroughly test the app to ensure all functionalities work as expected.
Submission Guidelines:
Submit the completed Flutter project including source code and necessary project files.
Include clear instructions on how to run and test the app.
Note: Feel free to utilize Flutter packages (e.g., shared_preferences, flutter_form_builder) as needed to accomplish the tasks efficiently.

