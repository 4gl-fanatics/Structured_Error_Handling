# Lab03: Custom errors; inner errors #

# Exercise 1: custom errors #
1. Create a new class that inherits from `Progress.Lang.AppError`. An example of this is `Lab01/CustomError.cls`
2. You can add custom properties, methods and other members to this class if you'd like.
3. Create a .P that throws this custom error and catches it (just to make sure it's working as expected).


# Exercise 2: creating inner errors #
1. Using the the custom error class you created in exercise 1, add a new property called `InnerError` with a type of `Progress.Lang.Error`.
2. Optionally, add a constructor that takes an instance of `Progress.Lang.Error` and assign the property value from this.
3. Create a new .P .
4. Add an internal procedure ("ip1"), and raise some form of error - potentially by running a .P from Lab01, or a simple AVM or AppError.
5. Add a `CATCH` block in the internal procedure; this should catch `Progress.Lang.Error` . In this block, throw a new instance of your custom error, making sure to set the caught error via constructor or otherwise.
6. In the main block, run the internal procedure. Add a `CATCH` block for your custom error. You can message the `InnerError` property or any other information.
7. Run the .P  and see the messages from the main block's `CATCH` block.

# Exercise 3: reading inner errors via reflection #
1. Open `Lab03/exercise03.p` in your editor
2. Run it, and open the `error.out` file once it has completed.
3. You can change the errors passed to the `printError` internal procedure to see various behaviours.
4. (Optional) Add an `InnerStop` property to your custom error class, similar to what was done in exercise 2. Add code to the `printError` internal procedure to print out information from that stop.

