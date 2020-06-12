[![Contributors][contributors-shield]][contributors-url]
[![MIT License][license-shield]][license-url]
#Bachelor Thesis: A study of spectral clustering techniques for machine learning applications


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)



<!-- ABOUT THE PROJECT -->
## About The Project

Clustering is considered one of the most important unsupervised learning method used to find hidden patterns and group data with similar characteristics. 

In particular, spectral clustering has become in recent years one of the most used techniques for clustering the data in its different properties and shapes, due to its simplic- ity, computational efficiency and accuracy. 

Our study focuses on finding meaningful communities in graphs emerging from machine learning applications. To achieve this, we initially experiment with different similarity graphs configurations, constructed from the datasets, and select the one that best describes the datasets under question.

Subsequently, we present different graph Laplacian, and choose the one that gives the optimal spec- tral clustering results based on a variety of evaluation metrics.

### Built With

* [Matlab](https://getbootstrap.com)

<!-- GETTING STARTED -->
## Getting Started
### Prerequisites

In order to use properly the code you need the Matlab R2019b release or later versions.

### Installation

1. Clone the repo
```
git clone https://github.com/LazarNajdenov/Bachelor-Thesis.git
```

<!-- USAGE EXAMPLES -->
## Usage

In order to cluster a particular dataset, using the ```src/main.m``` function, you have to download from the following [Dropbox](https://www.dropbox.com/sh/sdipet4h5vskcqm/AACcVBnk2ncdZD5pyZZCM-Ska?dl=0) repository, the ```Input_data``` folder, containing some of ```.mat``` datasets taken from the [openML Database](https://www.openml.org/search?type=data), used in our study. Then, if we want to cluster the ```Ecoli_all.mat```, we load it using the matlab command: 

```
load Ecoli_all.mat
```
Then we run our ```main.m```, by passing as first argument the name of the dataset, ```"Ecoli"``` in our case, and it will cluster the datasets using the default configurations specified in the function header. If one wants to use different configurations, when calling the ```main.m``` function, additional parameters can be used.

The ```src/selectionAndEvaluationScripts``` folder has been used for selecting the optimal similarity graph construction and Laplacian matrix configuration. The ```.mat``` files used for the selection/evaluation are also available in the [Dropbox](https://www.dropbox.com/sh/sdipet4h5vskcqm/AACcVBnk2ncdZD5pyZZCM-Ska?dl=0) repository, by downloading the ```selectionEvaluation``` and ```ArtificialDatasets``` folders.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Lazar Najdenov - najdel@usi.ch

Project Link: [https://github.com/LazarNajdenov/Bachelor-Thesis](https://github.com/LazarNajdenov/Bachelor-Thesis)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=flat-square
[contributors-url]: https://github.com/LazarNajdenov/Bachelor-Thesis/graphs/contributors
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/LazarNajdenov/Bachelor-Thesis/blob/master/LICENSE
