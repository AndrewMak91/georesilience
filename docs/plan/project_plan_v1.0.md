<!-- Plain-text export of project_plan_v1.0.docx so Claude Code and GitHub can read it. The .docx is the original. -->

GEORESILIENCE

Six-Month Geospatial Software Engineering Portfolio Project Plan

Project Title: GeoResilience — C++ Geospatial Environmental Risk Intelligence and Decision-Support Application

Project Duration: 26 weeks (six months)

Planned Effort: 91 hours

Weekly Commitment: 3–4 hours

Project Start Date: To be determined

Target Completion Date: Six months after the project start date

Project Owner: Project Developer

Document Version: 1.0

Project Status: Planned

1. EXECUTIVE SUMMARY

GeoResilience is a C++-based geospatial decision-support application designed to identify geographic areas that may warrant further investigation or investment in urban heat mitigation, tree planting, and cooling infrastructure.

The application will combine public geospatial, environmental, and demographic datasets to calculate transparent environmental screening indicators. These indicators will be processed through a reproducible spatial analytics pipeline and presented through an interactive visualization interface.

The project will demonstrate practical skills in C++ software engineering, geospatial data processing, statistical modeling, software testing, data engineering, and AI-assisted analytical interpretation.

The six-month development period will focus on building a reliable minimum viable product (MVP). Advanced functionality will be added only after the core processing engine and analytical results have been validated.

1.1 Project Problem Statement

Urban neighborhoods may experience different levels of surface heating, vegetation coverage, and population vulnerability. Identifying areas where these factors overlap can help inform preliminary environmental screening and guide further investigation.

GeoResilience will provide a reproducible method for comparing geographic areas using documented indicators, configurable scoring weights, and alternative analytical scenarios.

The application will not claim to predict individual heat-related illnesses or independently determine public funding allocations. Its purpose is to support preliminary screening and transparent comparison.

1.2 Primary Project Objective

Design, implement, test, and document a modular C++ geospatial application that ingests public spatial data, validates and transforms that data, calculates environmental screening indicators, generates reproducible priority scores, and presents the results through an accessible interface.

1.3 Project Success Criteria

The project will be considered successful when:

1.  The application builds using documented instructions.

2.  The C++ engine reads and validates supported geospatial inputs.

3.  Geographic boundaries can be associated with demographic records using stable identifiers.

4.  Spatial indicators and composite scores are calculated correctly.

5.  Analytical results can be independently checked against known test cases.

6.  Users can compare alternative weighting scenarios.

7.  Results can be exported in a documented, reusable format.

8.  An interactive map or equivalent visual demonstration presents the results.

9.  Automated tests cover critical calculations and data-validation logic.

10. Documentation explains the architecture, data sources, methodology, limitations, and reproducibility process.

11. Optional AI-generated explanations are grounded in calculated results and can be disabled without affecting the analytical engine.

2. PROJECT SCOPE

2.1 Included in the Initial Release

The six-month MVP will include:

-   A modular C++20 application.

-   A CMake-based build system.

-   GDAL/OGR integration for geospatial data access.

-   Support for a defined set of vector and tabular input formats.

-   Geographic identifier matching and demographic joins.

-   Coordinate reference system inspection and validation.

-   Geometry and attribute quality checks.

-   A repeatable data-processing pipeline.

-   Spatial aggregation or proximity calculations appropriate to the selected datasets.

-   Indicator normalization and weighted environmental screening scores.

-   Configurable model weights.

-   Basic sensitivity analysis and scenario comparison.

-   Exportable analytical results.

-   An interactive map and summary visualization.

-   Automated unit and integration tests.

-   Technical documentation and a reproducible demonstration.

-   Optional AI-assisted explanation of analytical results.

2.2 Explicitly Deferred Features

The following are outside the minimum required scope unless the core project is completed early:

-   Nationwide data processing.

-   Real-time environmental monitoring.

-   Predictive heat-illness modeling.

-   Production cloud deployment.

-   Complex distributed processing.

-   Advanced machine-learning models.

-   Automated public-policy recommendations.

-   Extensive user account management.

-   A sophisticated production-grade graphical interface.

-   A mandatory external AI service.

Scope-control rule: If the schedule slips, simplify the interface or defer AI functionality before reducing core testing, analytical correctness, or documentation.

3. TECHNICAL ARCHITECTURE AND TECHNOLOGY STACK

3.1 Recommended Technology Stack

  -------------------------------------------------------------------------------------------------------------
  Component                   Technology                           Primary Purpose
  --------------------------- ------------------------------------ --------------------------------------------
  Core programming language   C++20                                Spatial processing and analytical engine

  Build system                CMake                                Portable and reproducible builds

  Geospatial I/O              GDAL/OGR                             Read and write raster and vector data

  Geometry operations         GEOS, where needed                   Geometry validation and spatial predicates

  Local storage               GeoPackage / SQLite                  Spatial data storage and output delivery

  Automated testing           GoogleTest                           Unit and integration testing

  Version control             Git and GitHub                       Source control and portfolio publication

  Visualization               Python, GeoPandas, Streamlit         Lightweight interactive dashboard

  Optional AI                 Hosted API or local language model   Evidence-based explanations

  Documentation               Markdown                             Architecture, methodology, and user guides
  -------------------------------------------------------------------------------------------------------------

The C++ engine will remain independent of the visualization layer. Python will be used only where it materially reduces interface-development time.

3.2 Proposed Repository Structure

georesilience/

-   CMakeLists.txt

-   README.md

-   include/georesilience/

-   src/io/

-   src/spatial/

-   src/analytics/

-   src/cli/

-   tests/unit/

-   tests/integration/

-   data/sample/

-   dashboard/

-   docs/architecture.md

-   docs/data_dictionary.md

-   docs/methodology.md

-   docs/model_validation.md

-   examples/

-   benchmarks/

-   .github/workflows/

The structure may evolve during development. Only folders needed by the current milestone must be created.

3.3 High-Level Processing Flow

1.  Data ingestion.

2.  Input validation and quality reporting.

3.  Coordinate reference system and geometry handling.

4.  Spatial joins and indicator preparation.

5.  Statistical normalization and weighted scoring.

6.  Scenario analysis and result validation.

7.  Result export and summary generation.

8.  Interactive visualization.

9.  Optional evidence-grounded AI explanation.

10. Final reproducibility and release verification.

4. PROJECT TIMELINE OVERVIEW

The following table establishes the six major project phases and their completion targets.

  -------------------------------------------------------------------------------------------------------------------
  Phase                              Weeks      Planned Hours   Primary Deliverable                    Milestone
  ---------------------------------- ---------- --------------- -------------------------------------- --------------
  1. Foundation and environment      1–4        14              Working C++/GDAL prototype             M1

  2. Spatial data engineering        5–8        14              Repeatable validated pipeline          M2

  3. Spatial analytics engine        9–13       17.5            Initial indicator and scoring engine   M3

  4. Statistical evaluation          14–17      14              Sensitivity and validation report      M4

  5. Interface and optional AI       18–22      17.5            Interactive analytical demonstration   M5

  6. Testing and portfolio release   23–26      14              Documented release and demonstration   M6

  Total                              26 weeks   91 hours        Completed MVP                          6 milestones
  -------------------------------------------------------------------------------------------------------------------

The hours are planning estimates, not fixed deadlines for individual tasks. A task may move between weeks if a dependency takes longer than expected.

5. DETAILED WEEK-BY-WEEK DEVELOPMENT SCHEDULE

PHASE 1 — PROJECT FOUNDATION AND DEVELOPMENT ENVIRONMENT

Duration: Weeks 1–4

Effort: 14 hours

Phase objective: Establish the development environment, repository, architecture, and first working C++ program capable of reading geospatial data.

Week 1 — Project Initialization and Requirements

Estimated effort: 3.5 hours

Tasks

1.  Create the GeoResilience project repository.

2.  Initialize Git and configure the default branch.

3.  Write the initial project README.

4.  Define the problem statement and MVP requirements.

5.  Select one city or county as the initial study area.

6.  Identify one suitable geographic boundary dataset.

7.  Identify one demographic dataset and one candidate environmental dataset.

8.  Create a simple initial architecture diagram.

9.  Record software dependencies and setup decisions.

Deliverables

-   Initial Git repository.

-   Project README.

-   Requirements checklist.

-   Selected or provisionally selected study area.

-   Initial data-source register.

-   Preliminary architecture diagram.

Acceptance Criteria

-   The repository exists and contains the initial documentation.

-   The project objective and scope are clearly defined.

-   The initial data sources have documented origins.

-   The first development task is ready to execute.

Dependency: None.

Week 2 — C++ and CMake Build Environment

Estimated effort: 3.5 hours

Tasks

1.  Install or verify a compatible C++20 compiler.

2.  Install CMake and Git.

3.  Create the initial source and include directories.

4.  Write a minimal C++ program.

5.  Configure the CMake project.

6.  Build the executable from a clean build directory.

7.  Record the build and run commands.

8.  Verify that the program runs on the target development environment.

Deliverables

-   Initial CMakeLists.txt.

-   Minimal C++ source code.

-   Successful build and execution.

-   Development environment notes.

Acceptance Criteria

-   CMake configures the project successfully.

-   The C++ executable builds and runs.

-   Build instructions are recorded in the README.

Dependency: Week 1 repository initialization.

Week 3 — GDAL Integration and Geospatial File Reading

Estimated effort: 3.5 hours

Tasks

1.  Install or configure GDAL development libraries.

2.  Link GDAL to the CMake project.

3.  Open a small supported vector dataset.

4.  Read its layer metadata.

5.  Print the feature count and geometry type.

6.  Report the dataset coordinate reference system.

7.  Handle missing files and failed dataset opening.

8.  Document the geospatial library configuration.

Deliverables

-   GDAL-enabled C++ executable.

-   Initial geospatial file reader.

-   Basic metadata report.

-   Error-handling implementation.

Acceptance Criteria

-   The application opens a valid test dataset.

-   The application reports relevant dataset metadata.

-   An invalid path produces a useful error message rather than an unexplained failure.

Dependency: Week 2 build environment.

Week 4 — Foundation Review and Milestone 1

Estimated effort: 3.5 hours

Tasks

1.  Refactor the prototype into a small, understandable project structure.

2.  Separate geospatial I/O from command-line reporting where appropriate.

3.  Add initial tests or repeatable manual verification cases.

4.  Verify coordinate reference system reporting.

5.  Review setup instructions from a clean build.

6.  Finalize the initial architecture diagram.

7.  Document outstanding technical risks.

8.  Tag or record the first internal project milestone.

Deliverables

-   Working C++/GDAL prototype.

-   Initial project architecture documentation.

-   Reproducible build instructions.

-   Initial verification checklist.

-   Milestone 1 review notes.

MILESTONE 1 — DEVELOPMENT FOUNDATION COMPLETE

Target: End of Week 4.

The milestone is accepted when a documented C++ executable can read a supported spatial dataset and report its basic properties, and another user can follow the documented build instructions.

Gate decision: Do not begin complex spatial analysis until the build environment and basic geospatial I/O are reliable.

PHASE 2 — SPATIAL DATA ENGINEERING PIPELINE

Duration: Weeks 5–8

Effort: 14 hours

Phase objective: Develop a repeatable pipeline that ingests selected public datasets, validates them, joins demographic attributes to geographic units, and produces clean analytical inputs.

Week 5 — Data Acquisition and Study-Area Preparation

Estimated effort: 3.5 hours

Tasks

1.  Download geographic boundaries for the selected study area.

2.  Obtain the matching demographic table.

3.  Select a single environmental layer or prepare a synthetic environmental dataset for initial testing.

4.  Inspect file formats, attribute names, geographic identifiers, and metadata.

5.  Record source dates, geographic coverage, units, and known limitations.

6.  Verify data-use and attribution requirements.

7.  Store small, documented sample inputs in the repository where licensing permits.

Deliverables

-   Initial raw dataset collection.

-   Data-source register.

-   Preliminary data dictionary.

-   Sample input directory.

Acceptance Criteria

-   The selected datasets cover the intended study area.

-   Geographic identifiers can be matched or a documented matching strategy exists.

-   The environmental variable and its units are understood.

-   Data provenance and applicable licensing requirements are recorded.

Dependency: Milestone 1.

Week 6 — Attribute Joins and Data Validation

Estimated effort: 3.5 hours

Tasks

1.  Read the geographic boundaries and demographic records.

2.  Implement matching using stable geographic identifiers.

3.  Check for duplicate identifiers.

4.  Check for unmatched records.

5.  Detect missing or invalid numeric values.

6.  Verify that the expected number of geographic units is retained.

7.  Produce a summary of join results.

8.  Add test cases for duplicate and missing identifiers.

Deliverables

-   Geographic attribute-join implementation.

-   Join-quality report.

-   Initial data-validation functions.

-   Tests for common join failures.

Acceptance Criteria

-   Matching records join correctly.

-   Duplicate identifiers and unmatched records are reported.

-   Missing values are explicitly identified rather than silently treated as zero.

-   The output can be traced to the source records.

Dependency: Week 5 data preparation.

Week 7 — Coordinate Systems and Geometry Quality

Estimated effort: 3.5 hours

Tasks

1.  Inspect source coordinate reference systems.

2.  Define the coordinate system required for each operation.

3.  Implement checks for missing or unexpected CRS information.

4.  Validate geometry types and identify invalid geometries.

5.  Establish a documented geometry-repair or rejection policy.

6.  Select a suitable projected CRS for distance or area calculations.

7.  Test a small number of known spatial operations.

8.  Document how coordinate transformations are performed.

Deliverables

-   CRS validation logic.

-   Geometry-quality checks.

-   Spatial preprocessing rules.

-   CRS and geometry test cases.

Acceptance Criteria

-   CRS problems are detected and reported.

-   Distance and area operations use an appropriate projected coordinate system when required.

-   Invalid geometries follow a documented policy.

-   Known test cases produce expected spatial results.

Dependency: Weeks 5–6.

Week 8 — Pipeline Integration and Milestone 2

Estimated effort: 3.5 hours

Tasks

1.  Connect ingestion, validation, and joining into a repeatable workflow.

2.  Add command-line input and output paths.

3.  Add basic logging and useful error messages.

4.  Write validated outputs to GeoPackage or another documented format.

5.  Add a small integration test using sample data.

6.  Document the pipeline's input and output contracts.

7.  Run the pipeline from raw inputs to cleaned outputs.

8.  Record known limitations and the next development priorities.

Deliverables

-   End-to-end spatial data pipeline.

-   Cleaned sample output dataset.

-   Validation and processing logs.

-   Pipeline usage documentation.

-   Integration test.

-   Milestone 2 review notes.

MILESTONE 2 — DATA ENGINEERING PIPELINE COMPLETE

Target: End of Week 8.

The milestone is accepted when the application can process the selected inputs, validate basic data quality, join demographic attributes, and produce a documented output dataset through a repeatable workflow.

Gate decision: Do not build the full scoring model on top of data whose identifiers, units, or coordinate systems are not understood.

PHASE 3 — SPATIAL ANALYTICS ENGINE

Duration: Weeks 9–13

Effort: 17.5 hours

Phase objective: Build the core analytical functionality that transforms validated spatial inputs into interpretable environmental indicators and a preliminary priority score.

Week 9 — Analytical Requirements and Indicator Definitions

Estimated effort: 3.5 hours

Tasks

1.  Define the geographic unit of analysis.

2.  Select a limited set of indicators for the MVP.

3.  Define what each indicator measures and its units.

4.  Determine whether higher values represent greater exposure, greater vulnerability, or better environmental conditions.

5.  Define how green-space or vegetation indicators will be converted into a lack-of-green-space indicator.

6.  Document missing-data handling.

7.  Create hand-calculated examples for testing.

Deliverables

-   Indicator specification.

-   Data-to-indicator mapping.

-   Preliminary scoring methodology.

-   Hand-calculated reference examples.

Acceptance Criteria

-   Each indicator has a documented definition and direction.

-   The required inputs are available or have a defined fallback for development.

-   The methodology distinguishes measured values from proxies and assumptions.

Dependency: Milestone 2.

Week 10 — Spatial Aggregation and Indicator Calculation

Estimated effort: 3.5 hours

Tasks

1.  Implement the spatial operation required for the selected environmental layer.

2.  Aggregate environmental measurements to the selected geographic units.

3.  Calculate applicable proximity or area-based indicators.

4.  Handle geographic units with no valid measurements.

5.  Record indicator values and data-quality flags.

6.  Test the calculation against a small known dataset.

7.  Separate spatial operations from presentation logic.

Deliverables

-   Initial spatial indicator engine.

-   Aggregated indicator output.

-   Tests for representative spatial calculations.

-   Indicator-quality report.

Acceptance Criteria

-   Calculations follow documented spatial and measurement rules.

-   Missing measurements are identified.

-   Results can be traced to the inputs and operation used.

Dependency: Week 9 indicator definitions.

Week 11 — Normalization and Composite Scoring

Estimated effort: 3.5 hours

Tasks

1.  Implement a documented normalization method.

2.  Start with min-max normalization or a percentile-based method appropriate to the data.

3.  Confirm that all score components have consistent directionality.

4.  Implement configurable nonnegative weights.

5.  Verify that the weights sum to one.

6.  Calculate the preliminary composite screening score.

7.  Produce ranked geographic units.

8.  Compare results with hand-calculated examples.

Deliverables

-   Indicator-normalization functions.

-   Configurable weighted scoring function.

-   Preliminary ranked output.

-   Unit tests for score calculations.

Acceptance Criteria

-   The normalization method is applied consistently.

-   Invalid weights are rejected or reported.

-   The calculated scores match hand-calculated reference cases within a defined numeric tolerance.

-   Rankings can be reproduced from the same inputs and configuration.

Dependency: Week 10 indicator calculations.

Week 12 — Configuration, Export, and Reproducibility

Estimated effort: 3.5 hours

Tasks

1.  Move model weights and relevant settings into a configuration file.

2.  Add command-line options for input, output, and configuration paths.

3.  Export indicator values and scores in a documented format.

4.  Record the configuration used for each run.

5.  Add run metadata, such as the input identifiers and model version.

6.  Test that identical inputs and settings reproduce equivalent outputs.

7.  Verify that the core engine works without the dashboard or AI.

Deliverables

-   Configurable scoring workflow.

-   Exportable results dataset.

-   Example configuration file.

-   Reproducibility test.

-   Updated user instructions.

Acceptance Criteria

-   The analytical workflow is not dependent on hard-coded weights.

-   Output files include the fields required to interpret the results.

-   The same inputs and settings produce equivalent analytical outputs.

Dependency: Week 11 scoring implementation.

Week 13 — Analytical Integration and Milestone 3

Estimated effort: 3.5 hours

Tasks

1.  Integrate spatial indicator calculation and scoring.

2.  Run the complete analytical workflow on the selected sample study area.

3.  Inspect the highest- and lowest-ranked geographic units.

4.  Verify the calculations for selected records.

5.  Produce an initial map or tabular summary of the results.

6.  Document the scoring equation and assumptions.

7.  Fix critical correctness issues.

8.  Review readiness for statistical evaluation.

Deliverables

-   Integrated C++ spatial analytics engine.

-   Preliminary priority scores.

-   Ranked spatial output.

-   Initial analytical summary.

-   Updated methodology documentation.

MILESTONE 3 — ANALYTICAL ENGINE COMPLETE

Target: End of Week 13.

The milestone is accepted when the engine can process validated data, calculate the selected indicators, normalize them, apply configurable weights, and export reproducible preliminary screening scores.

Gate decision: Scores must be mathematically verifiable before the project moves into sensitivity analysis and user-facing explanations.

PHASE 4 — STATISTICAL MODELING AND EVALUATION

Duration: Weeks 14–17

Effort: 14 hours

Phase objective: Evaluate the robustness and interpretability of the scoring model, test alternative assumptions, and document limitations.

Week 14 — Alternative Weighting Scenarios

Estimated effort: 3.5 hours

Tasks

1.  Define at least three documented weighting scenarios.

2.  Include the initial illustrative scenario.

3.  Calculate scores and rankings for each scenario.

4.  Compare rankings between scenarios.

5.  Identify geographic units whose positions change substantially.

6.  Record the score and rank changes.

7.  Generate a simple comparison table or chart.

Deliverables

-   Scenario configuration files.

-   Scenario comparison outputs.

-   Initial ranking-stability summary.

Acceptance Criteria

-   Each scenario has documented weights.

-   Weights satisfy the model constraints.

-   Scenario results can be reproduced.

-   Ranking changes can be inspected and explained.

Dependency: Milestone 3.

Week 15 — Indicator Relationships and Data Quality

Estimated effort: 3.5 hours

Tasks

1.  Calculate basic descriptive statistics for the selected indicators.

2.  Examine distributions and unusual values.

3.  Calculate correlations where the data supports meaningful comparison.

4.  Identify possible redundancy among indicators.

5.  Examine the effect of missing values.

6.  Check for inconsistent units or unexpected scaling.

7.  Document the limitations of the available data.

Deliverables

-   Indicator summary statistics.

-   Correlation table or chart.

-   Data-quality findings.

-   Updated limitations register.

Acceptance Criteria

-   Summary statistics are generated reproducibly.

-   Correlations are interpreted as associations, not proof of causation.

-   Material missing-data or redundancy concerns are documented.

Dependency: Week 14 scenario preparation and the analytical outputs.

Week 16 — Model Sensitivity and Validation

Estimated effort: 3.5 hours

Tasks

1.  Compare priority rankings across the documented scenarios.

2.  Quantify rank changes using an appropriate comparison method.

3.  Check the effect of plausible changes in selected model weights.

4.  Verify selected outputs independently using hand calculations or a trusted GIS workflow.

5.  Investigate differences between the C++ output and the reference calculation.

6.  Record unresolved discrepancies.

7.  Define the limitations of the score as a screening index.

Deliverables

-   Model-sensitivity results.

-   Independent calculation checks.

-   Validation notes.

-   Updated model limitations.

Acceptance Criteria

-   Representative calculations are independently checked.

-   Important ranking changes are quantified.

-   Discrepancies are resolved or explicitly documented.

-   No unsupported predictive claims are made.

Dependency: Weeks 14–15.

Week 17 — Evaluation Report and Milestone 4

Estimated effort: 3.5 hours

Tasks

1.  Consolidate the statistical evaluation findings.

2.  Explain the selected normalization method.

3.  Document the initial and alternative weightings.

4.  Summarize ranking stability and material sensitivity findings.

5.  Describe missing-data and uncertainty limitations.

6.  Prepare summary charts and tables.

7.  Update the methodology and model-validation documents.

8.  Approve the analytical results for interface development.

Deliverables

-   Statistical evaluation report.

-   Model methodology documentation.

-   Sensitivity-analysis charts.

-   Validation summary.

-   Updated limitations register.

MILESTONE 4 — STATISTICAL EVALUATION COMPLETE

Target: End of Week 17.

The milestone is accepted when the scoring methodology, alternative scenarios, validation checks, and important limitations are documented and the outputs are sufficiently stable and interpretable for demonstration.

Gate decision: The interface must communicate the model as an environmental screening tool, not a validated prediction of individual health outcomes.

PHASE 5 — APPLICATION INTERFACE AND OPTIONAL AI INTEGRATION

Duration: Weeks 18–22

Effort: 17.5 hours

Phase objective: Make the analytical outputs accessible through a lightweight interface, allow scenario exploration, and introduce an optional evidence-grounded AI explanation feature if time permits.

Week 18 — Interface Design and Results Contract

Estimated effort: 3.5 hours

Tasks

1.  Define the minimum dashboard layout.

2.  Identify the essential output fields required by the interface.

3.  Select a simple map-and-chart presentation approach.

4.  Prepare an example analytical output for interface development.

5.  Define how geographic units will be selected.

6.  Decide how indicator values, ranks, and scores will be displayed.

7.  Document the boundary between the C++ engine and the presentation layer.

Deliverables

-   Interface outline or wireframe.

-   Output-field specification.

-   Sample result file.

-   Interface integration notes.

Acceptance Criteria

-   The interface design covers map display, score inspection, and scenario comparison.

-   The interface consumes exported results rather than reimplementing authoritative analytical calculations.

Dependency: Milestone 4.

Week 19 — Map, Rankings, and Summary Charts

Estimated effort: 3.5 hours

Tasks

1.  Set up the visualization environment.

2.  Load the exported spatial results.

3.  Display geographic units with a clear priority-score legend.

4.  Show a ranked table of geographic units.

5.  Add summary statistics and a simple chart.

6.  Display key indicator values for selected units.

7.  Add data-source and methodology notes.

8.  Verify that the displayed values match the analytical outputs.

Deliverables

-   Initial interactive dashboard.

-   Priority map.

-   Ranked results table.

-   Indicator summary visualization.

Acceptance Criteria

-   The map and table show consistent results.

-   Score direction and legend categories are clearly explained.

-   Users can identify the data and methodology underlying the displayed values.

Dependency: Week 18.

Week 20 — Scenario Controls and Analytical Explanations

Estimated effort: 3.5 hours

Tasks

1.  Add controls for selecting predefined scoring scenarios.

2.  If feasible, add editable weight controls with validation.

3.  Refresh rankings when the scenario changes.

4.  Display the selected weights and scenario name.

5.  Explain which indicators contributed to a selected area's score.

6.  Add a comparison view for two geographic units or two scenarios.

7.  Test that interface changes do not silently alter the underlying source data.

Deliverables

-   Scenario-selection controls.

-   Updated rankings and charts.

-   Indicator-contribution explanation.

-   Scenario comparison view.

Acceptance Criteria

-   The selected scenario is clearly identified.

-   Invalid weight combinations are rejected or handled transparently.

-   Displayed rankings correspond to the selected scenario.

-   Users can understand the main contributors to a score.

Dependency: Week 19 and the configurable scoring workflow.

Week 21 — Optional AI-Assisted Analysis

Estimated effort: 3.5 hours

Tasks

1.  Define the questions the AI assistant is allowed to answer.

2.  Prepare structured result summaries for selected geographic units.

3.  Include indicator values, score components, model weights, and relevant caveats.

4.  Connect an AI service or local model if a suitable implementation can be completed within the available time.

5.  Ask the assistant to explain differences between two geographic units.

6.  Test questions for which the available data is insufficient.

7.  Ensure the assistant does not invent scores, measurements, or citations.

8.  Keep the AI component optional and isolated from the core engine.

Deliverables

-   AI integration prototype, if feasible.

-   Structured analytical context.

-   Example question-and-answer interactions.

-   AI reliability test cases.

-   Documentation of limitations and fallback behavior.

Acceptance Criteria

-   Any AI-generated explanation is grounded in retrieved analytical outputs.

-   The assistant distinguishes recorded values from interpretation.

-   Unsupported questions receive a clear limitation statement.

-   The application continues to function if the AI service is unavailable.

Dependency: Weeks 19–20 and stable analytical outputs.

Scope-control rule: If AI integration threatens the testing or release schedule, replace it with deterministic, template-based explanations. A reliable analytical engine is more important than a sophisticated AI interface.

Week 22 — Interface Integration and Milestone 5

Estimated effort: 3.5 hours

Tasks

1.  Run the complete pipeline and generate current results.

2.  Load the results into the dashboard.

3.  Verify maps, charts, rankings, and scenario selection.

4.  Verify that exported results remain accessible.

5.  Test the application with a new sample run.

6.  Review basic usability and error messages.

7.  Record remaining interface issues.

8.  Prepare a short end-to-end demonstration.

Deliverables

-   Integrated dashboard.

-   Working scenario exploration.

-   Demonstration dataset and instructions.

-   Optional AI demonstration.

-   Milestone review notes.

MILESTONE 5 — INTERACTIVE APPLICATION COMPLETE

Target: End of Week 22.

The milestone is accepted when a user can inspect ranked areas, understand the principal indicator values, explore at least predefined alternative scenarios, and view consistent results through the interface.

If AI has been implemented, its explanations must remain evidence-grounded and optional.

PHASE 6 — TESTING, PERFORMANCE, DOCUMENTATION, AND PORTFOLIO RELEASE

Duration: Weeks 23–26

Effort: 14 hours

Phase objective: Verify the end-to-end system, document its performance and limitations, prepare a reproducible public repository, and release a polished portfolio demonstration.

Week 23 — Automated Testing and End-to-End Verification

Estimated effort: 3.5 hours

Tasks

1.  Review unit-test coverage for data validation.

2.  Review tests for normalization and score calculations.

3.  Add tests for invalid weights and missing inputs.

4.  Add or improve integration tests.

5.  Run the pipeline from the documented sample inputs.

6.  Verify that expected output fields and records are present.

7.  Check representative results against reference calculations.

8.  Resolve high-priority defects.

Deliverables

-   Updated automated test suite.

-   End-to-end verification results.

-   Defect list and resolution notes.

Acceptance Criteria

-   Critical calculation and validation tests pass.

-   Invalid inputs are handled predictably.

-   The sample workflow produces the expected output structure.

-   Material defects are resolved or disclosed.

Dependency: Milestone 5.

Week 24 — Performance Benchmarking and Build Verification

Estimated effort: 3.5 hours

Tasks

1.  Define a representative test dataset and record its size.

2.  Record the hardware and software environment.

3.  Measure end-to-end processing time.

4.  Measure a relevant stage separately if practical.

5.  Record memory use if a suitable measurement method is available.

6.  Identify one performance bottleneck.

7.  Make a targeted optimization only if justified.

8.  Repeat the benchmark and document the result.

9.  Verify a clean build using the written instructions.

Deliverables

-   Benchmark report.

-   Recorded test environment.

-   Before-and-after measurements if optimization is performed.

-   Clean-build verification notes.

Acceptance Criteria

-   Benchmark results include the dataset size and test environment.

-   Performance claims are supported by recorded measurements.

-   A clean build succeeds using the documented process.

Dependency: Week 23 test stability.

Week 25 — Documentation and Portfolio Preparation

Estimated effort: 3.5 hours

Tasks

1.  Finalize the project README.

2.  Document the system architecture.

3.  Finalize the data dictionary.

4.  Document data sources, attribution, and applicable licenses.

5.  Finalize the methodology and model-validation reports.

6.  Add installation and build instructions.

7.  Add a complete example run with expected outputs.

8.  Capture map and dashboard screenshots.

9.  Prepare a short technical project summary.

10. Record known limitations and future improvements.

Deliverables

-   Complete README.

-   Architecture documentation.

-   Data and methodology documentation.

-   Installation and usage instructions.

-   Example outputs and screenshots.

-   Portfolio project summary.

Acceptance Criteria

-   A new user can understand the purpose and limitations of the application.

-   Data sources and applicable attribution requirements are documented.

-   The build and sample-run instructions are complete.

-   The example output is consistent with the documented methodology.

Dependency: Weeks 23–24.

Week 26 — Final Release and Milestone 6

Estimated effort: 3.5 hours

Tasks

1.  Run the complete documented workflow from a clean environment or clean build.

2.  Verify the sample dataset and configuration.

3.  Execute the automated tests.

4.  Review the README and documentation links.

5.  Verify that no secrets or API keys are committed.

6.  Confirm that data redistribution complies with the applicable licenses.

7.  Capture the final demonstration.

8.  Tag a versioned release.

9.  Publish or finalize the repository.

10. Write a final retrospective and identify possible future extensions.

Deliverables

-   Versioned GeoResilience release.

-   Public or portfolio-ready source repository.

-   Reproducible sample workflow.

-   Final demonstration.

-   Completed project documentation.

-   Final project retrospective.

MILESTONE 6 — PORTFOLIO RELEASE COMPLETE

Target: End of Week 26.

The milestone is accepted when the application builds, tests pass, sample results can be reproduced, the documentation is complete, and a reviewer can inspect and understand the project's engineering decisions.

6. MILESTONE REGISTER AND ACCEPTANCE GATES

  --------------------------------------------------------------------------------------------------------------------------------------------------------
  Milestone           Target Week   Required Evidence                                             Acceptance Decision
  ------------------- ------------- ------------------------------------------------------------- --------------------------------------------------------
  M1: Foundation      4             C++/GDAL executable, build instructions, architecture         Spatial file opens and metadata are reported

  M2: Data pipeline   8             Validated inputs, joins, logs, clean spatial output           Raw data can be transformed repeatably

  M3: Analytics       13            Indicators, normalization, configurable scores, tests         Scores match reference calculations

  M4: Evaluation      17            Scenario comparison, sensitivity results, validation report   Model behavior and limitations are documented

  M5: Interface       22            Interactive map, ranked table, scenario controls              Users can explore consistent analytical results

  M6: Release         26            Tests, benchmark, documentation, release, demo                A reviewer can build and reproduce the sample workflow
  --------------------------------------------------------------------------------------------------------------------------------------------------------

Milestone Review Procedure

At the end of each phase:

1.  Confirm that the required deliverables exist.

2.  Run the relevant tests or verification steps.

3.  Record unresolved defects and risks.

4.  Decide whether the phase is accepted.

5.  If acceptance criteria are not met, identify the smallest necessary corrective action.

6.  Reprioritize lower-value features if corrective work threatens the schedule.

7.  Update the next phase's task list.

A milestone should not be marked complete merely because its scheduled week has ended.

7. PROJECT DEPENDENCIES AND CRITICAL PATH

The main development dependency chain is:

1.  Development environment and geospatial file access.

2.  Reliable dataset ingestion and validation.

3.  Correct spatial indicator calculations.

4.  Verified normalization and scoring.

5.  Statistical evaluation and scenario comparison.

6.  Visualization and optional AI integration.

7.  Automated end-to-end verification.

8.  Documentation and final release.

Critical-Path Activities

The following tasks are most likely to affect the overall completion date:

-   Correct installation and configuration of GDAL.

-   Selection of compatible datasets with stable geographic identifiers.

-   Correct handling of coordinate systems and geometry.

-   Reliable spatial aggregation and score calculations.

-   Validation of results against independent reference calculations.

-   Integration of exported analytical results with the interface.

Dependency Management Rules

-   Do not begin advanced statistical analysis before the initial scoring model works.

-   Do not depend on AI functionality for any core analytical result.

-   Do not begin major dashboard development before the output data format is stable.

-   Do not postpone all testing until the final month.

-   Do not expand the study area until the end-to-end workflow works on a small sample.

-   Use synthetic data for early tests when obtaining or processing public data would otherwise block development.

8. STATISTICAL MODEL AND SCORING METHODOLOGY

8.1 Initial Indicator Model

The initial model will use three conceptual indicators for each geographic unit:

-   H: normalized heat exposure.

-   V: normalized population vulnerability.

-   G: normalized lack of green space.

The composite screening score for geographic unit i is:

Sᵢ = wH × Hᵢ + wV × Vᵢ + wG × Gᵢ

where:

-   Sᵢ is the composite screening score.

-   Hᵢ is the normalized heat-exposure indicator.

-   Vᵢ is the normalized population-vulnerability indicator.

-   Gᵢ is the normalized lack-of-green-space indicator.

-   wH, wV, and wG are nonnegative weights that sum to one.

An initial illustrative scenario may use:

-   Heat exposure: 40%.

-   Population vulnerability: 35%.

-   Lack of green space: 25%.

These are starting assumptions for analysis, not scientifically established policy priorities.

8.2 Required Model Checks

The project must:

1.  Verify indicator directionality.

2.  Document normalization methods.

3.  Verify that weights sum to one.

4.  Test score calculations using hand-calculated examples.

5.  Compare at least three weighting scenarios.

6.  Inspect relationships among indicators.

7.  Investigate missing-data effects.

8.  Document limitations and uncertainty.

9.  Avoid presenting the screening score as a validated health-outcome prediction.

8.3 Interpretation Requirements

The dashboard and report should explain:

-   What each indicator measures.

-   Which data sources contribute to the score.

-   How normalization works.

-   Which weights were used.

-   Which components contribute to a selected score.

-   Whether a geographic unit's ranking changes under alternative assumptions.

-   What the score cannot establish.

9. OPTIONAL AI INTEGRATION PLAN

AI is a supporting feature, not the source of analytical truth.

Permitted Functions

-   Explain calculated scores.

-   Compare two geographic units using supplied data.

-   Summarize differences between scoring scenarios.

-   Retrieve relevant methodology documentation.

-   Generate preliminary narrative summaries of validated outputs.

Required Safeguards

-   All numerical scores and spatial calculations originate from the analytical engine.

-   AI responses use retrieved result records and documented methodology.

-   Missing evidence must be disclosed.

-   The application must remain usable without an AI service.

-   API credentials must not be committed to the repository.

-   AI-generated interpretations must not be represented as independently verified scientific conclusions.

AI Acceptance Test

Example question:

"Why is Area A ranked above Area B?"

The response should compare the two areas' actual indicator values, score components, and configured weights. It should explain which factors account for the difference and identify any relevant data limitations.

If the required records are unavailable, the assistant should state that the available data is insufficient.

10. ENGINEERING QUALITY GATES

  -------------------------------------------------------------------------------------------------------
  Quality Area              Minimum Acceptance Criterion
  ------------------------- -----------------------------------------------------------------------------
  Build system              Clean build succeeds using documented instructions

  Input handling            Supported files load and invalid files produce useful errors

  Data quality              Missing values, duplicate IDs, and relevant geometry issues are reported

  CRS handling              Coordinate reference systems are checked and transformations are documented

  Spatial correctness       Representative spatial operations match known reference results

  Statistical correctness   Scores match hand-calculated test cases within a defined tolerance

  Configuration             Model weights and relevant settings are externally configurable

  Reproducibility           Equivalent inputs and configuration produce equivalent analytical outputs

  Automated testing         Critical calculations and validation paths have automated tests

  Performance               Processing time is measured on a documented dataset

  Visualization             Displayed values match exported analytical results

  AI reliability            Explanations use supplied evidence and disclose unsupported questions

  Documentation             A new user can build, run, and understand the sample application

  Release readiness         Repository, sample data, licenses, and demonstration are reviewed
  -------------------------------------------------------------------------------------------------------

11. PROJECT RISK REGISTER

  -----------------------------------------------------------------------------------------------------------------------------------------------
  Risk                                              Likelihood   Impact   Mitigation
  ------------------------------------------------- ------------ -------- -----------------------------------------------------------------------
  GDAL installation or linking problems             Medium       High     Verify GDAL early and keep a minimal working example

  Public datasets are difficult to combine          High         High     Start with one small study area and stable geographic identifiers

  Data processing consumes too much time            Medium       High     Use a small sample dataset and synthetic test fixtures

  Spatial results are incorrect                     Medium       High     Validate CRS, geometry, units, and independent reference calculations

  Scope expands beyond available hours              High         High     Defer advanced features and enforce the MVP requirements

  Statistical interpretation is overstated          Medium       High     Document assumptions and treat the model as a screening index

  Dashboard integration takes too long              Medium       Medium   Keep the C++ engine independent and use exported results

  AI answers are inaccurate                         Medium       High     Ground explanations in structured records and make AI optional

  Performance cannot be demonstrated meaningfully   Low          Medium   Benchmark a documented dataset and report the test environment

  Licensing or attribution is incomplete            Low–Medium   High     Record source licenses and attribution requirements during ingestion

  Final documentation is rushed                     Medium       High     Update documentation throughout the project
  -----------------------------------------------------------------------------------------------------------------------------------------------

Risk Review Schedule

-   Week 1: Establish the initial risk register.

-   Week 4: Review build and dependency risks.

-   Week 8: Review data quality and ingestion risks.

-   Week 13: Review analytical correctness risks.

-   Week 17: Review statistical and interpretation risks.

-   Week 22: Review interface and AI risks.

-   Week 26: Review remaining risks before release.

12. WEEKLY WORKING ROUTINE

The project will use a consistent weekly routine to prevent learning activities from displacing implementation.

  ---------------------------------------------------------------------------
  Activity                                               Planned Time
  ------------------------------------------------------ --------------------
  Review one relevant concept or technical document      30 minutes

  Implement a small feature or complete a defined task   1 hour 45 minutes

  Test, debug, and inspect results                       45 minutes

  Document progress and prepare the next task            30 minutes

  Total                                                  3 hours 30 minutes
  ---------------------------------------------------------------------------

Each week should produce one verifiable result, such as a working function, automated test, validated dataset, chart, benchmark, or documented design decision.

If only three hours are available in a particular week, prioritize the week's main deliverable and defer lower-priority refinements.

If four hours are available, use the extra time to address defects, improve tests, or document the work.

13. CHANGE CONTROL AND SCOPE MANAGEMENT

Any significant new feature should be evaluated against the remaining schedule and the project's primary success criteria.

Before accepting a scope change, answer:

1.  Does the feature improve the core geospatial engineering demonstration?

2.  Is it required for the MVP?

3.  Can it be completed within the remaining time?

4.  Will it delay testing or documentation?

5.  Is there a simpler implementation that achieves the same goal?

Priority Order

Priority 1 — Essential

-   Working C++ build.

-   Reliable spatial data pipeline.

-   Correct analytical calculations.

-   Automated tests.

-   Reproducible outputs.

-   Clear technical documentation.

Priority 2 — High value

-   Statistical sensitivity analysis.

-   Interactive map and charts.

-   Scenario comparison.

-   Performance benchmark.

-   Polished demonstration.

Priority 3 — Optional extensions

-   AI question-answering interface.

-   Advanced clustering or spatial autocorrelation.

-   Sophisticated user controls.

-   Expanded geographic coverage.

-   Production deployment.

Features in Priority 3 must not jeopardize Priority 1.

14. FINAL PORTFOLIO DELIVERABLES

At the end of Week 26, the project should contain the following artifacts.

Software

-   C++20 analytical application.

-   CMake build configuration.

-   GDAL/OGR-based spatial data processing.

-   Reusable data-validation and analytical components.

-   Configurable scoring workflow.

-   Exportable spatial results.

-   Optional interactive dashboard.

-   Optional AI explanation component.

Testing and Evaluation

-   Unit tests for critical calculations.

-   Integration tests for the main processing workflow.

-   Reference calculations for representative spatial and statistical operations.

-   Scenario sensitivity results.

-   Performance benchmark with documented context.

-   Final known-limitations register.

Documentation

-   Project README.

-   Architecture diagram.

-   Installation and build instructions.

-   Data dictionary.

-   Data-source and attribution register.

-   Methodology document.

-   Model-validation and sensitivity report.

-   Example configuration and run instructions.

-   Future development roadmap.

Demonstration

-   A small, reproducible public-data example.

-   A map displaying the screening results.

-   A ranked geographic-unit table.

-   An example of alternative weighting scenarios.

-   Screenshots or a short recorded walkthrough.

-   A versioned repository release.

15. FINAL PROJECT ACCEPTANCE CHECKLIST

The project is ready for portfolio release when the following requirements have been verified.

Core Application

-   C++ application builds using documented instructions.

-   GDAL/OGR reads the supported input dataset.

-   Input validation and error handling work.

-   Geographic identifiers and joins are checked.

-   Spatial indicators are calculated correctly.

-   Normalization and weighted scoring pass reference tests.

-   Configuration can be changed without modifying core scoring code.

-   Results can be exported and inspected.

Analytical Quality

-   Indicator definitions and units are documented.

-   The scoring methodology is documented.

-   Alternative weighting scenarios are compared.

-   Sensitivity and data-quality findings are recorded.

-   Important limitations are clearly stated.

-   The application does not make unsupported predictive claims.

User Interface

-   A user can inspect the ranked areas.

-   The map and summary table display consistent results.

-   Alternative scenarios can be explored.

-   The methodology and data sources are accessible.

-   Optional AI functionality can be disabled without breaking the core workflow.

Release

-   Automated tests pass.

-   The benchmark is documented.

-   The README and setup instructions are complete.

-   Sample inputs and example outputs are available where licensing permits.

-   Data attribution and licensing requirements are satisfied.

-   No secrets or API credentials are committed.

-   The final demonstration has been captured.

-   A versioned release is available.

16. PROJECT COMPLETION DEFINITION

GeoResilience will be considered complete when it demonstrates an end-to-end geospatial engineering workflow rather than merely displaying a map.

A reviewer should be able to inspect the source code, build the application, run the sample data pipeline, examine the calculated indicators and scores, review the tests, understand the statistical methodology, compare alternative scenarios, and reproduce the documented example results.

The final product should demonstrate practical competence in C++ development, geospatial data engineering, spatial analysis, statistical evaluation, testing, reproducibility, and technical communication.

The project's principal achievement will be a small but credible software system with transparent calculations and defensible engineering decisions. Optional AI features should enhance the user experience without replacing or obscuring the underlying analytical logic.

Final target: Complete the GeoResilience MVP, document its limitations, and publish a reproducible portfolio demonstration at the end of Week 26.
