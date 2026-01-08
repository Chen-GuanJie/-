早期的视觉语言模型主要聚焦于图像描述任务（Image Captioning）[56-60]。谷歌于2015年发表的论文“Show and Tell: A Neural Image Caption Generator”首次将卷积神经网络与循环神经网络结合，实现了端到端的看图说话，为视觉与语言的结合奠定了重要基础[61]。随后，研究逐步扩展到更复杂的视觉问答（Visual Question Answering, VQA）领域[62-65]。Antol等人提出首个大规模VQA数据集，要求模型基于图像与自然语言问题生成答案[63]。该任务强调跨模态推理，使视觉语言模型从简单的描述生成迈向细粒度理解与多样化交互。在图像描述与问答任务的推动下，注意力机制成为突破性进展[66,67]。Xu等人发表于ICML2015的工作的引入软注意力，使生成过程能够聚焦于图像中的相关区域[68]。随后，Anderson等人提出结合目标检测与任务驱动的分层注意力机制，实现对象级语义对齐，并在COCO与VQA挑战中取得领先成绩[69]。这标志着视觉语言模型进入注重细粒度跨模态对齐的阶段。自2019年起，受BERT等预训练语言模型启发[70-73]，视觉语言模型进入跨模态预训练阶段。代表性工作如LXMERT通过大规模图文对数据和多任务预训练学习通用的跨模态表示，并在VQA等任务上取得显著性能提升[74]。同类模型还包括ViLBERT[75]、VisualBERT[76]和UNITER[77]。这一系列工作推动了视觉语言模型从面向特定任务的模型向通用基础模型的转变，为后续多模态智能的发展奠定了坚实基础。

进入2021年前后，大规模弱监督学习推动了视觉语言模型的跨越式发展。OpenAI提出的CLIP模型[78]在4亿图文对上进行对比学习，训练出共享嵌入空间的图像与文本表征，展现出显著的零样本能力，标志着视觉语言模型向开放域应用迈出重要一步。Google随后提出的ALIGN模型进一步验证了这一范式在跨任务迁移中的有效性[79]。在此基础上，研究逐渐转向与生成式模型的结合，例如BLIP实现了理解与生成任务的统一[80]，而BLIP-2通过轻量化适配器将图像编码器与大型语言模型高效衔接，显

著提升了跨模态建模效率[81]。与此同时，DeepMind提出的Flamingo模型展示了多模态少样本学习的潜力，仅依赖上下文提示即可在视觉问答、图像描述等任务中取得接近甚至超越专用模型的表现[82]。这些研究表明，在弱监督与生成式预训练的推动下，视觉语言模型正逐步具备开放环境中的灵活推理与广泛适应能力。进入2023年以后，视觉语言模型的研究重心进一步转向多模态大模型的构建。OpenAI在技术报告“GPT-4 Technical Report”中提出的GPT-4首次具备了多模态输入能力，能够接受文本和图像作为输入并生成高质量文本输出[83]。GPT-4不仅在传统语言任务上表现出色，在图像理解、复杂推理以及跨模态对话中也展现出接近人类水平的表现。几乎同期，Google DeepMind推出Gemini系列模型，该模型自设计之初便整合了文本、图像、代码、音频与视频等多模态信息，实现了更广泛的任务覆盖[22]。Gemini展示了在跨模态推理和创作上的新能力，例如基于图像生成程序或表格，或融合多模态内容生成复合答案。Anthropic推出的Claude3系列同样在多模态交互上展现出强大性能[23]。

这些多模态大模型的出现，推动视觉语言模型从单一任务工具转向通用人工智能应用基座，并在智能体研究中迅速落地。例如，基于视觉语言模型的桌面或移动GUI 智能体能够通过看屏幕和理解用户指令完成复杂操作，代表性应用包括微软提出的UFO[84]、Anthropic的Claude Computer Use[85]，以及OpenAI发布的Computer-Using Agent与Operator系统[86,87]。这些应用表明，视觉语言模型已经从感知理解任务扩展到实际的人机交互与自动化执行层面，逐步成为支撑智能体与下一代交互系统的核心。

[50] Xing M, Zhang R, Xue H, et al. Understanding the Weakness of Large Language Model Agents within a Complex Android Environment[C]//Proceedings of the 30th ACM SIGKDD Conference on Knowledge Discovery and Data Mining, KDD 2024, Barcelona, Spain, August 25-29, 2024: 6061-6072.





[51] Zhou S, Xu F F, Zhu H, et al. WebArena: A Realistic Web Environment for Building Autonomous Agents[C]//Proceedings of the Twelfth International Conference on Learning Representations, ICLR 2024, Vienna, Austria, May 7-11, 2024.





[52] Wang X, Wang B, Lu D, et al. OpenCUA: Open Foundations for Computer-Use Agents[J]. arXiv preprint arXiv:2508.09123, 2025: 1-42.





[53] Li W, Bishop W E, Li A, et al. On the Effects of Data Scale on UI Control Agents[C]//Advances in Neural Information Processing Systems 38: Annual Conference on Neural Information Processing Systems 2024, NeurIPS 2024,





Vancouver, BC, Canada, December 10-15, 2024, 37: 92130-92154.





[54] Google. Gemini 2.0 Flash | Generative AI on Vertex AI[EB/OL].(2024). https://cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/2-0-flash.





[55] Anthropic. Claude 3.7 Sonnet and Claude Code[EB/OL].(2025). https://www.anthropic.com/news/claude-3-7-sonnet.





[56] Aneja J, Deshpande A, Schwing A G. Convolutional Image Captioning[C]//Proceedings of the 2018 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2018, Salt Lake City, UT, USA, June 18-22, 2018: 5561-5570.





[57] Hossain M Z, Sohel F, Shiratuddin M F, et al. A Comprehensive Survey of Deep Learning for Image Captioning[J]. ACM Computing Surveys, 2019, 51(6): 1-36.





[58] Ghandi T, Pourreza H, Mahyar H. Deep Learning Approaches on Image Captioning: A Review[J]. ACM Computing Surveys, 2023, 56(3): 1-39.





[59] You Q, Jin H, Wang Z, et al. Image Captioning with Semantic Attention[C]//Proceedings of the 2016 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2016, Las Vegas, NV, USA, June 27-30, 2016: 4651-4659.





[60] Herdade S, Kappeler A, Boakye K, et al. Image Captioning: Transforming Objects Into Words[C]//Advances in Neural Information Processing Systems 32: Annual Conference on Neural Information Processing Systems 2019, NeurIPS 2019, Vancouver, BC, Canada, December 8-14, 2019, 32: 11135-11145.





[61] Vinyals O, Toshev A, Bengio S, et al. Show and tell: A neural image caption generator[C]//Proceedings of the 2015 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2015, Boston, MA, USA, June 7-12, 2015: 3156-3164.





[62] Li Q, Tao Q, Joty S, et al. VQA-E: Explaining, Elaborating, and Enhancing Your Answers for Visual Questions[C]//Proceedings of the 15th European Conference on Computer Vision, ECCV 2018, Munich, Germany, September 8-14, 2018, 552-567.





[63] Antol S, Agrawal A, Lu J, et al. VQA: Visual Question Answering[C]//2015 IEEE International Conference on Computer Vision, ICCV 2015, Santiago, Chile, December 7-13, 2015: 2425-2433.





[64] Goyal Y, Khot T, Summers-Stay D, et al. Making the V in VQA Matter: Elevating the Role of Image Understanding in Visual Question Answering[C]//Proceedings of the 2017 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2017, Honolulu, HI, USA, July 21-26, 2017: 6325-6334.





[65] Singh A, Natarajan V, Shah M, et al. Towards VQA Models That Can Read[C]//Proceedings of the 2019 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2019, Long Beach, CA, USA, June 16-20, 2019: 8317-8326.





[66] Guo M-H, Xu T-X, Liu J-J, et al. Attention Mechanisms in Computer Vision: A Survey[J]. Computational Visual Media, 2022, 8(3): 331-368.





[67] Vaswani A, Shazeer N, Parmar N, et al. Attention is All you Need[C]//Advances in Neural Information Processing Systems 30: Annual Conference on Neural Information Processing Systems 2017, NIPS 2017, Long Beach, CA, USA, December 4-9, 2017, 30: 5998-6008.





[68] Xu K, Ba J, Kiros R, et al. Show, Attend and Tell: Neural Image Caption Generation with Visual Attention[C]//Proceedings of the 32nd International Conference on Machine Learning, ICML 2015, Lille, France, July 6-11, 2015: 2048-2057.





[69] Anderson P, He X, Buehler C, et al. Bottom-Up and Top-Down Attention for Image Captioning and Visual Question Answering[C]//Proceedings of the 2018 IEEE Conference on Computer Vision and Pattern Recognition, CVPR 2018, Salt Lake City, UT, USA, June 18-22, 2018: 6077-6086.





[70] Liu Y, Ott M, Goyal N, et al. RoBERTa: A Robustly Optimized BERT Pretraining Approach[J]. arXiv preprint arXiv:1907.11692, 2019: 1-13.





[71] Yang Z, Dai Z, Yang Y, et al. XLNet: Generalized Autoregressive Pretraining for Language Understanding[C]//Advances in Neural Information Processing Systems 32: Annual Conference on Neural Information Processing Systems 2019, NeurIPS 2019, Vancouver, BC, Canada, December 8-14, 2019, 32: 5754-5764.





[72] Radford A, Wu J, Child R, et al. Language Models are Unsupervised Multitask Learners[J]. OpenAI blog, 2019: 1-24.





[73] Devlin J, Chang M-W, Lee K, et al. BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding[C]//Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics, NAACL 2019, Minneapolis, MN, USA, June 2-7, 2019: 4171-4186.





[74] Tan H, Bansal M. LXMERT: Learning Cross-Modality Encoder Representations from Transformers[C]//Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing, EMNLP-IJCNLP 2019, Hong Kong, November 3-7, 2019: 5099-5110.





[75] Lu J, Batra D, Parikh D, et al. ViLBERT: Pretraining Task-Agnostic Visiolinguistic





Representations for Vision-and-Language Tasks[C]//Advances in Neural Information Processing Systems 32: Annual Conference on Neural Information Processing Systems 2019, NeurIPS 2019, Vancouver, BC, Canada, December 8-14, 2019, 32: 13-23.





[76] Li L H, Yatskar M, Yin D, et al. VisualBERT: A Simple and Performant Baseline for Vision and Language[J]. arXiv preprint arXiv:1908.03557, 2019: 1-14.





[77] Chen Y-C, Li L, Yu L, et al. UNITER: UNiversal Image-Text Representation Learning[C]//Proceedings of the 16th European Conference on Computer Vision, ECCV 2020, Glasgow, UK, August 23-28, 2020: 104-120.





[78] Radford A, Kim J W, Hallacy C, et al. Learning Transferable Visual Models From Natural Language Supervision[C]//Proceedings of the 38th International Conference on Machine Learning, ICML 2021, Virtual Event, July 18-24, 2021: 8748-8763.





[79] Jia C, Yang Y, Xia Y, et al. Scaling Up Visual and Vision-Language Representation Learning With Noisy Text Supervision[C]//Proceedings of the 38th International Conference on Machine Learning, ICML 2021, Virtual Event, July 18-24, 2021: 4904-4916.





[80] Li J, Li D, Xiong C, et al. BLIP: Bootstrapping Language-Image Pre-training for Unified Vision-Language Understanding and Generation[C]//Proceedings of the 39th International Conference on Machine Learning, ICML 2022, Baltimore, Maryland, USA, July 17-23, 2022: 12888-12900.





[81] Li J, Li D, Savarese S, et al. BLIP-2: Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models[C]//Proceedings of the 40th International Conference on Machine Learning, ICML 2023, Honolulu, Hawaii, USA, July 23-29, 2023: 19730-19742.





[82] Alayrac J-B, Donahue J, Luc P, et al. Flamingo: a Visual Language Model for Few-Shot Learning[C]//Advances in Neural Information Processing Systems 35: Annual Conference on Neural Information Processing Systems 2022, NeurIPS 2022, New Orleans, LA, USA, Nov 28-Dec 9, 2022, 35: 23716-23736.





[83] OpenAI, Achiam J, Adler S, et al. GPT-4 Technical Report[J]. arXiv preprint arXiv:2303.08774, 2023: 1-100.





[84] Zhang C, Li L, He S, et al. UFO: A UI-Focused Agent for Windows OS Interaction[C]//Proceedings of the 2025 Conference of the Nations of the Americas Chapter of the Association for Computational Linguistics, NAACL 2025, Albuquerque, New Mexico, USA, April 29-May 4, 2025: 597-622.





[85] Anthropic. Introducing computer use, a new Claude 3.5 Sonnet, and Claude 3.5 Haiku[EB/OL].(2024). https://www.anthropic.com/news/3-5-models-and-computer-use.





[86] OpenAI. Computer-Using Agent[EB/OL].(2025). https://openai.com/index/computer-using-agent/.





[87] OpenAI. Introducing Operator[EB/OL].(2025). https://openai.com/index/introducing-operator/.





[88] Sun L, Chen X, Chen L, et al. META-GUI: Towards Multi-modal Conversational Agents on Mobile GUI[C]//Proceedings of the 2022 Conference on Empirical Methods in Natural Language Processing, EMNLP 2022, Abu Dhabi, United Arab Emirates, December 7-11, 2022: 6699-6712.





[89] 肖泳利. 面向智能个人助理的用户多意图识别方法研究[D]. 哈尔滨工业大学, 2022.





[90] Hong W, Wang W, Lv Q, et al. CogAgent: A Visual Language Model for GUI Agents[C]//Proceedings of the 2024 IEEE/CVF Conference on Computer Vision and Pattern Recognition, CVPR 2024, Seattle, WA, USA, June 16-22, 2024: 14281-14290.


