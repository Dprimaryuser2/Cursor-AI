# Used to execute command-line commands (e.g., running Robot Framework tests).
import subprocess
import os
import time
# From the concurrent.futures module, these are used for managing and running threads concurrently.
from concurrent.futures import ThreadPoolExecutor, as_completed

# Define your test suites and the browsers you want to use
test_suites = [
    ".\\TestCases\\Web_POS\\Billing\\billing_test_cases.robot",
    ".\\TestCases\\Web_POS\\Billing\\add_to_cart_test_cases.robot",
    ".\\TestCases\\Web_POS\\Billing\\carry_bag_test_cases.robot",
    ".\\TestCases\\Web_POS\\Billing\\manual_discount_test_case.robot"
]
browsers = ["chrome", "edge"]  # Browsers to use

# Initializes a dictionary where each browser is marked as True, indicating that the browser is initially free.
browser_status = {browser: True for browser in browsers}

# This function sets the environment variable BROWSER for the specific browser, runs the test suite using the subprocess.run method, and updates the browser_status to indicate that the browser is free after the test completes.
def run_test_suite(test_suite, browser):
    os.environ['BROWSER'] = browser  # Set the BROWSER environment variable
    print(f"Running {test_suite} on {browser} with BROWSER={os.getenv('BROWSER')}")

    suite_name = os.path.splitext(os.path.basename(test_suite))[0]
    output_dir = f"results/{suite_name}_{browser}"
    os.makedirs(output_dir, exist_ok=True)

    result = subprocess.run([
        "robot",
        "--variable", f"BROWSER:{browser}",
        "--outputdir", output_dir,
        test_suite
    ], capture_output=True, text=True)

    print(f"Output for {test_suite} on {browser}:")
    print(result.stdout)
    print(result.stderr)

    if result.returncode == 0:
        print(f"Completed {test_suite} on {browser} successfully.")
    else:
        print(f"Failed {test_suite} on {browser}.")

    browser_status[browser] = True  # Mark browser as free

def run_in_parallel(suites, browsers):
    # Creates a ThreadPoolExecutor instance with a number of worker threads equal to the number of browsers. The ThreadPoolExecutor manages a pool of threads to execute tasks asynchronously.
    with ThreadPoolExecutor(max_workers=len(browsers)) as executor:
        # Initializes an empty list called futures to store the Future objects, which represent the asynchronous execution of each test suite.
        futures = []
        # Initializes an index counter suite_index to keep track of the current test suite being assigned to a browser.
        suite_index = 0

        # Start initial suites on browsers
        for browser in browsers:
            if suite_index < len(suites):
                print(f"Starting {suites[suite_index]} on {browser}")
                # Submits a task to the executor to run the run_test_suite function with the current suite and browser.
                # It returns a Future object representing the asynchronous execution of the test suite.
                future = executor.submit(run_test_suite, suites[suite_index], browser)
                suite_index += 1
                browser_status[browser] = False
                # Adds the Future object to the futures list for tracking.
                futures.append(future)

        # Assign remaining suites to available browsers. Continues assigning suites until all have been assigned.
        while suite_index < len(suites):
            for browser in browsers:
                if browser_status[browser]:  # Check if browser is free
                    # Find a future that is done. Creates a list of Future objects from futures that have completed their tasks.
                    done_futures = [f for f in futures if f.done()]
                    if done_futures:
                        for done_future in done_futures:
                            futures.remove(done_future)
                        # Start the next suite on the free browser
                        print(f"Assigning {suites[suite_index]} to free browser {browser}")
                        # Submits a new task to the executor to run the next test suite on the free browser.
                        future = executor.submit(run_test_suite, suites[suite_index], browser)
                        suite_index += 1
                        browser_status[browser] = False   # Marks the browser as busy.
                        futures.append(future)
            time.sleep(5)  # Wait before checking again

def combine_reports(output_dir="results"):
    output_files = []
    for root, dirs, files in os.walk(output_dir):
        for file in files:
            if file == "output.xml":
                output_files.append(os.path.join(root, file))

    if output_files:
        combined_output = os.path.join(output_dir, "output.xml")
        combined_log = os.path.join(output_dir, "log.html")
        combined_report = os.path.join(output_dir, "report.html")

        # Combine all output.xml files into a single report
        subprocess.run([
            "rebot",
            "--output", combined_output,
            "--log", combined_log,
            "--report", combined_report
        ] + output_files)

def main():
    print("Starting parallel test execution...")
    run_in_parallel(test_suites, browsers)
    print("Combining reports...")
    combine_reports()

if __name__ == "__main__":
    main()